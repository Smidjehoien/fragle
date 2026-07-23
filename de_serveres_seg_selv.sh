#!/bin/bash

echo "🔍 Leter etter tjenester som serverer seg selv..."
sleep 1

# Finn tjenester som starter automatisk
auto=$(systemctl list-unit-files --type=service | grep enabled)

# Finn prosesser som kan være mistenkelige
sneaky=$(ps aux | grep -Ei 'chrome|tracker|agent|daemon|sniff|auto' | grep -v grep)

echo
echo "💾 Automatisk aktiverte tjenester:"
echo "---------------------------------"
echo "$auto" | while read -r line; do
  service=$(echo "$line" | awk '{print $1}')
  echo "🤖 $service har *valgt* å være aktiv. Den trenger ikke deg."
done

echo
echo "🕵️ Mistenkelig selvbetjente prosesser:"
echo "-------------------------------------"
echo "$sneaky" | while read -r line; do
  echo "👀 ${line:0:100}..."
done

echo
echo "🍵 Avslutter. Husk: De serveres seg selv. Men du kan fortsatt trekke te selv."
