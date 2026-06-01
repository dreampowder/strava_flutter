#!/usr/bin/env python3
"""Bundle Strava's split Swagger 2.0 spec into one self-contained file.

Source: https://developers.strava.com/swagger/ (root swagger.json + 22 model
files in this directory, fetched by fetch.sh). External $refs like
`.../activity.json#/DetailedActivity` are rewritten to local
`#/definitions/DetailedActivity` and every definition is inlined.

Writes ../strava_v3.swagger.json (valid Swagger 2.0). Convert to OpenAPI 3.0
afterwards with:  npx -y swagger2openapi@7 ../strava_v3.swagger.json -o ../strava_v3.openapi.json

A few bugs in Strava's published spec are normalized here so the bundle
validates; see the inline comments.
"""
import json, glob, os, re

SRC = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.normpath(os.path.join(SRC, ".."))

root = json.load(open(os.path.join(SRC, "swagger.json")))

# Collect every definition from the model files.
definitions = {}
SKIP = {"swagger.json"}
for fn in glob.glob(os.path.join(SRC, "*.json")):
    if os.path.basename(fn) in SKIP:
        continue
    for name, schema in json.load(open(fn)).items():
        definitions[name] = schema

EXT = re.compile(r"^https?://developers\.strava\.com/swagger/[^#]+#/(.+)$")

def localize(node):
    """Recursively rewrite external $refs to #/definitions/Name."""
    if isinstance(node, dict):
        out = {}
        for k, v in node.items():
            if k == "$ref" and isinstance(v, str):
                m = EXT.match(v)
                if m:
                    out[k] = f"#/definitions/{m.group(1)}"
                elif v.startswith("#/") and not v.startswith(
                        ("#/definitions/", "#/parameters/")):
                    # bare same-file ref, e.g. "#/TimedZoneRange"
                    out[k] = f"#/definitions/{v[2:]}"
                else:
                    out[k] = v
            else:
                out[k] = localize(v)
        return out
    if isinstance(node, list):
        return [localize(x) for x in node]
    return node

definitions = {k: localize(v) for k, v in definitions.items()}
bundled = localize(root)
bundled["definitions"] = dict(sorted(definitions.items()))

for path, ops in bundled.get("paths", {}).items():
    for method, op in ops.items():
        if not isinstance(op, dict):
            continue
        params = op.setdefault("parameters", [])
        # Strava marks the athlete-update `weight` as a path param though it is
        # really a query param. Fix any path param missing from the URL template.
        for param in params:
            if (isinstance(param, dict) and param.get("in") == "path"
                    and "{" + param.get("name", "") + "}" not in path):
                param["in"] = "query"
        # Strava omits the {id} path-param declaration on /athletes/{id}/routes.
        # Inject any templated var that lacks a corresponding parameter.
        declared = {p["name"] for p in params
                    if isinstance(p, dict) and p.get("in") == "path"}
        for var in re.findall(r"\{(\w+)\}", path):
            if var not in declared:
                is_int = var == "id" or var.lower().endswith("id")
                params.insert(0, {
                    "name": var, "in": "path", "required": True,
                    "type": "integer" if is_int else "string",
                    **({"format": "int64"} if is_int else {}),
                })
        # Strava's spec uses OpenAPI-3 `content` blocks inside this 2.0 doc for
        # the route export_gpx/export_tcx file responses. Normalize to valid 2.0.
        for code, resp in op.get("responses", {}).items():
            content = resp.pop("content", None)
            if not content:
                continue
            media, body = next(iter(content.items()))
            op.setdefault("produces", [])
            if media not in op["produces"]:
                op["produces"].append(media)
            schema = body.get("schema", {})
            if schema.get("format") == "binary":
                schema = {"type": "file"}
            resp["schema"] = schema

# Verify every ref now resolves locally.
text = json.dumps(bundled)
unresolved = sorted(set(re.findall(r'"\$ref":\s*"([^"]+)"', text)))
bad = [r for r in unresolved
       if not (r.startswith("#/definitions/") or r.startswith("#/parameters/"))]
missing = [r.split("/")[-1] for r in unresolved
           if r.startswith("#/definitions/") and r.split("/")[-1] not in bundled["definitions"]]

print(f"definitions inlined: {len(bundled['definitions'])}")
print(f"paths: {len(bundled.get('paths', {}))}")
print(f"external refs remaining: {bad if bad else 'NONE'}")
print(f"dangling definition refs: {missing if missing else 'NONE'}")

out = os.path.join(OUT, "strava_v3.swagger.json")
json.dump(bundled, open(out, "w"), indent=2, ensure_ascii=False)
print("wrote", os.path.relpath(out, OUT), os.path.getsize(out), "bytes")
