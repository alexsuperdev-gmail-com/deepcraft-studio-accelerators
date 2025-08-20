#!/bin/bash
# Converts all top-level metadata.json files to .yml in ModelYmls
set -e
mkdir -p ModelYmls
for d in */ ; do
  if [ -f "$d/metadata.json" ]; then
    name=$(basename "$d")
    yml_file="ModelYmls/${name}.yml"
    # Use yq if available, else fallback to python
    if command -v yq >/dev/null 2>&1; then
      yq -P . "$d/metadata.json" > "$yml_file"
    else
      python3 -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < "$d/metadata.json" > "$yml_file"
    fi
  fi
done
