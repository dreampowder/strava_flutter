#!/usr/bin/env bash
# Rebuild the bundled specs from sources/ and validate them.
# Requires: python3 (+ pyyaml), node/npx.
set -euo pipefail
cd "$(dirname "$0")"

python3 bundle.py
npx -y swagger2openapi@7 ../strava_v3.swagger.json -o ../strava_v3.openapi.json --warnOnly >/dev/null

python3 - <<'PY'
import json, yaml
for b in ["../strava_v3.openapi", "../strava_v3.swagger"]:
    d = json.load(open(b + ".json"))
    yaml.safe_dump(d, open(b + ".yaml", "w"), sort_keys=False, allow_unicode=True, width=120)
    print("wrote", b.split("/")[-1] + ".yaml")
PY

echo "--- validate ---"
npx -y @apidevtools/swagger-cli@4 validate ../strava_v3.swagger.json
npx -y @apidevtools/swagger-cli@4 validate ../strava_v3.openapi.json
