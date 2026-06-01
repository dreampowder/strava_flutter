# Strava API v3 — OpenAPI / Swagger specs

Self-contained, **validated** machine-readable specs for the Strava V3 API,
derived from Strava's official (but split-across-files and slightly buggy)
published spec at <https://developers.strava.com/swagger/> — the same spec that
powers the [API playground](https://developers.strava.com/playground/) and the
[reference docs](https://developers.strava.com/docs/reference/).

These are reference artifacts for this package (and anyone who wants a single
spec file to feed into codegen, Postman, Swagger UI, etc.). They are **not**
shipped in the published Dart package.

## Files

| File | Format | Notes |
|------|--------|-------|
| `strava_v3.openapi.json` / `.yaml` | **OpenAPI 3.0.0** | Canonical / modern. Use this. |
| `strava_v3.swagger.json` / `.yaml` | Swagger 2.0 | Faithful bundle of the upstream 2.0 spec. |
| `sources/` | — | Raw upstream files + build scripts (see below). |

Both bundles cover **32 paths** and **60 schema definitions**, with every
`$ref` resolved to a local reference (no external file dependencies).

## Rebuilding

```bash
cd openapi/sources
./fetch.sh      # re-download the upstream split spec files
./build.sh      # bundle -> swagger 2.0 -> openapi 3.0 -> yaml -> validate
```

Requires `python3` (+ `pyyaml`), `node`/`npx`, and `curl`.

`bundle.py` inlines all external `$ref`s and normalizes three bugs in Strava's
published spec so the result validates:

1. The route `export_gpx` / `export_tcx` responses use OpenAPI-3 `content`
   blocks inside a Swagger-2.0 document → converted to 2.0 `produces` + a
   `{type: file}` response schema.
2. `PUT /athlete` declares its `weight` field as a `path` parameter though no
   `{weight}` exists in the URL → corrected to a `query` parameter.
3. `GET /athletes/{id}/routes` omits the `{id}` path-parameter declaration →
   injected.

## Source of truth

Upstream is Swagger 2.0. The OpenAPI 3.0.0 file is generated from the bundled
2.0 file via [`swagger2openapi`](https://github.com/Mermade/oas-kit). If Strava
updates their spec, re-run `fetch.sh` then `build.sh`.
