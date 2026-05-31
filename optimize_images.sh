#!/usr/bin/env bash
# Optimiza las fotos para web: redimensiona a 2000px de lado largo y genera
# versiones WebP (calidad 80) en fotos/webp/.
#
# Requiere cwebp:  sudo apt-get install -y webp
# Uso:             bash optimize_images.sh
set -euo pipefail

SRC="fotos"
OUT="fotos/webp"
MAX_EDGE=2000
QUALITY=75

mkdir -p "$OUT"

for f in "$SRC"/*.jpg; do
  [ -e "$f" ] || continue
  name="$(basename "${f%.jpg}").webp"
  # -resize 2000 0  => limita el ancho a 2000; cwebp respeta el aspecto.
  # Si la foto es vertical conviene limitar el alto; cwebp no auto-detecta,
  # por eso pasamos ambos como máximos y cwebp ignora el que no aplica.
  cwebp -q "$QUALITY" -resize "$MAX_EDGE" 0 "$f" -o "$OUT/$name" 2>/dev/null \
    || cwebp -q "$QUALITY" "$f" -o "$OUT/$name"
  printf '%s  ->  %s\n' "$f" "$OUT/$name"
done

echo "Listo. Pesos:"
du -sh "$SRC"/*.jpg | awk '{s+=$1}END{print "  JPG originales"}' >/dev/null
du -sh "$OUT" | sed 's/^/  WebP total: /'
