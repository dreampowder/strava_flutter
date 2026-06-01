#!/usr/bin/env bash
# Fetch Strava's published Swagger 2.0 spec (root + all split model files)
# from https://developers.strava.com/swagger/ into this directory.
set -euo pipefail
cd "$(dirname "$0")"

BASE="https://developers.strava.com/swagger"
FILES=(
  swagger
  activity activity_stats activity_total activity_type athlete club comment
  fault gear lap latlng map photo route segment segment_effort split sport_type
  stream upload waypoint zones
)

for f in "${FILES[@]}"; do
  curl -fsSL "$BASE/$f.json" -o "$f.json"
  printf '  fetched %s.json\n' "$f"
done
echo "done: ${#FILES[@]} files"
