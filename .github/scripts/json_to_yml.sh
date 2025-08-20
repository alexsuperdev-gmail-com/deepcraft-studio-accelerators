#!/bin/bash
# Converts all top-level metadata.json files to .yml in ModelYmls
set -e
mkdir -p ModelYmls
for d in */ ; do
  if [ -f "$d/metadata.json" ]; then
    name=$(basename "$d")
    yml_file="ModelYmls/${name}.yml"
    # Use yq if available, else fallback to python
    python3 -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < "$d/metadata.json" > "$yml_file"    
  fi
done

cd ModelYmls
echo "cards:" > ai_hub_cards.yml
for f in *.yml; do
  [ "$f" = "ai_hub_cards.yml" ] && continue
  name="${f%.yml}"
  echo "  $name:" >> ai_hub_cards.yml
  sed 's/^/    /' "$f" >> ai_hub_cards.yml
  #echo "" >> ai_hub_cards.yml
  #echo "    # ---" >> ai_hub_cards.yml
  #echo "" >> ai_hub_cards.yml
  rm "$f"
done
