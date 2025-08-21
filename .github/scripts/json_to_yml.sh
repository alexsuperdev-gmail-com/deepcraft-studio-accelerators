#!/bin/bash
# Converts all top-level metadata.json files to .yml in ModelYmls
set -e
echo "cards:" > ModelYmls/ai_hub_cards.yml
for d in */ ; do
  if [ -f "$d/metadata.json" ]; then
    name=$(basename "$d")
    echo "  $name:" >> ModelYmls/ai_hub_cards.yml
    python3 -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < "$d/metadata.json" | sed 's/^/    /' >> ModelYmls/ai_hub_cards.yml
    #echo "" >> ModelYmls/ai_hub_cards.yml   
  fi
done
# Optionally, remove all .yml files except ai_hub_cards.yml if any exist from previous runs
find ModelYmls -maxdepth 1 -type f -name '*.yml' ! -name 'ai_hub_cards.yml' -delete
