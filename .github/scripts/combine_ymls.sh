#!/bin/bash
# Combines all .yml files in ModelYmls into ai_hub_cards.yml under 'cards:'
set -e
cd ModelYmls

echo "cards:" > ai_hub_cards.yml
for f in *.yml; do
  [ "$f" = "ai_hub_cards.yml" ] && continue
  name="${f%.yml}"
  echo "  $name:" >> ai_hub_cards.yml
  sed 's/^/    /' "$f" >> ai_hub_cards.yml
  echo "" >> ai_hub_cards.yml
  echo "    # ---" >> ai_hub_cards.yml
  echo "" >> ai_hub_cards.yml
  rm "$f"
done
