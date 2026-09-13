# Cableado final de fotos — FASE B (hecho)

Fecha: 2026-09-13 · Base: propuesta `2026-09-13-seleccion-final.md` + tus 4 decisiones · Commit: `d52ddc9`

## Qué se hizo

1. **22 conversiones** con `cwebp -metadata none`, lado mayor ≤ 2000 (`-resize 0 2000` solo en las
   dos de cabana-3 de 2252×4000). q78 en general; q75 en las cuatro con más follaje
   (refugio-03, cabana-03, galeria-02, galeria-03) para contenerlas.
2. **og-image.jpg** 1200×630 a partir del hero: franja central y 250–754 de la original
   (960×504), escalada ×1,25 con Lanczos, JPEG q82 progresivo. Generado con
   `uv run --with pillow` (no hay ImageMagick/PIL/cjpeg en la máquina). 178 KB.
3. **index.html**: og:image, twitter:image, preload del hero e `"image"` del JSON-LD
   cambiados en el mismo commit. JSON-LD no se tocó fuera de `"image"`. Hero,
   experiencia y `#galeria` pasan de `<picture>` + fallback JPG a `<img>` WebP directo
   (mismo criterio que ya tenían las fichas desde el 9/9). Layout, CSS y JS sin cambios;
   el lightbox sigue agrupando por `.cab-img img, .cab-thumb img` y `.gal-grid .gi img`.
4. **Borrados**: `fotos/IMG_0386…0399.jpg` (12), `fotos/webp/IMG_*.webp` (12), `fotos/webp/casa-06.webp`.
   `fotos/` queda sin JPG; solo `fotos/webp/`.
5. `width`/`height` reales en los 22 `<img>`; `loading="lazy"` + `decoding="async"` en
   todos salvo el hero (`loading="eager"` + `fetchpriority="high"`). Alt en español con
   "Mar de las Pampas" en todos.

## Tus decisiones aplicadas

| # | Decisión | Estado |
|---|---|---|
| 1 | Hero = `cabana-10/PHOTO-2026-08-20-22-11-04.jpg`, vertical, del pool | ✅ `fotos/webp/hero.webp` 960×1280, 204 KB |
| 2 | galeria-04 repite casa-02 (entrepiso con remos); no usar frente de cabaña 3 | ✅ `galeria-04.webp` es byte-idéntico a `casa-02.webp` (mismo origen, mismos parámetros). No hay `cabana-3/…15-09.jpg` en ningún lado |
| 3 | refugio-01 = la de cabana-4 con hogar de piedra | ✅ `refugio-01.webp` 960×1280 (antes 1126×2000, la de cabana-3) |
| 4 | URLs absolutas a `mdqclio.github.io/puertodelfin/`; JSON-LD image = og + hero + galeria-01 | ✅ ver bloque abajo |

```html
<meta property="og:image" content="https://mdqclio.github.io/puertodelfin/og-image.jpg">
<meta name="twitter:image" content="https://mdqclio.github.io/puertodelfin/og-image.jpg">
<link rel="preload" as="image" href="fotos/webp/hero.webp" type="image/webp" fetchpriority="high">
"image": [
  "https://mdqclio.github.io/puertodelfin/og-image.jpg",
  "https://mdqclio.github.io/puertodelfin/fotos/webp/hero.webp",
  "https://mdqclio.github.io/puertodelfin/fotos/webp/galeria-01.webp"
]
```

`og:image:width/height` ya decían 1200×630 y ahora es verdad (antes apuntaban a un JPG vertical de 1179×1446).

## ⚠️ PENDIENTE DE CUTOVER a www.puertodelfin.com

Cuando el dominio sirva el repo, cambiar **todo junto** de `https://mdqclio.github.io/puertodelfin/`
a `https://www.puertodelfin.com/`:

- `index.html` línea 28 `og:image`, línea 37 `twitter:image`, líneas 61–63 JSON-LD `"image"`.
- Ya apuntan a www (no tocar hasta el cutover, ya están bien para ese momento): `canonical`
  (l. 10), `og:url` (l. 27), JSON-LD `@id` y `url` (l. 55, 58), `sitemap.xml`, `robots.txt`.
- Después del cambio: re-scrapear en el Facebook Sharing Debugger y mandar un link por
  WhatsApp a un número propio para que se regenere el preview (WhatsApp cachea agresivo).

## Archivos finales (fotos/webp/ + raíz)

```
hero.webp          960×1280  204K   cabana-10/…22-11-04         (hero, eager)
og-image.jpg       1200×630  178K   recorte del hero            (raíz del repo)
experiencia.webp   900×1600  151K   cabana-12/023bc5d2
galeria-01.webp    960×1280  195K   cabana-10/…22-11-13  GALERÍA (bloque grande)
galeria-02.webp    960×1280  258K   cabana-5/…21-57-43   GALERÍA
galeria-03.webp    960×1280  185K   cabana-4/…22-01-24 2
galeria-04.webp    960×1280   76K   cabana-8/…21-48-28 3 (= casa-02)
galeria-05.webp    960×1280   61K   cabana-10/…22-11-08 2 GALERÍA
refugio-01.webp    960×1280   85K   cabana-4/…22-01-25 3
refugio-02.webp   1126×2000  148K   cabana-3/…20-15-10 2
refugio-03.webp    960×1280  250K   cabana-2/…20-17-01
refugio-04.webp   1126×2000  109K   cabana-3/…20-15-10
refugio-05.webp    960×1280   61K   cabana-4/…22-01-25
cabana-01.webp    1200×1600  103K   cabana-9/…22-04-46 3
cabana-02.webp     960×1280   77K   cabana-5/…21-57-45 3
cabana-03.webp     960×1280  227K   cabana-5/…21-57-43 2
cabana-04.webp     960×1280   79K   cabana-10/…22-11-06
cabana-05.webp     960×1280   75K   cabana-5/…21-57-44 3
casa-01.webp       900×1600   89K   cabana-11/0aeb2403
casa-02.webp       960×1280   76K   cabana-8/…21-48-28 3
casa-03.webp       960×1280  150K   cabana-11/dfaefc17 2
casa-04.webp       900×1600  113K   cabana-12/ea7dc787
casa-05.webp       900×1600   63K   cabana-11/3e6a1537
```

Total imágenes servidas: **3,0 MB** (antes: 12 JPG 4,7 MB + 12 WebP 3,0 MB + 16 WebP 2,0 MB ≈ 9,7 MB en el repo,
de los que la página cargaba ~4,5 MB). Peso por encima del pliegue: hero 204 KB + fuentes.

## Verificaciones

- `grep IMG_0 index.html` → 0 resultados. `grep casa-06` → 0. Sin `<picture>` ni `<source>` en el HTML.
- Las 22 rutas `fotos/webp/*.webp` referenciadas existen en disco (script de chequeo, 0 faltantes).
- JSON-LD parsea (`json.loads`) y `"image"` tiene las 3 URLs.
- 23 `<img>`: 22 con `width`/`height` reales; el que no tiene es `#lbImg` del lightbox (vacío por diseño, ya estaba así).
- Diff completo de `index.html` revisado antes del commit: 45 líneas, 19+/26−; solo los bloques hero,
  head (og/twitter/preload/JSON-LD), 3 fichas, experiencia y `#galeria`.
- No pude renderizar en Chromium headless (faltan libs del sistema, ya visto el 9/9). Mirá en el
  celular: hero (que la franja muestre casa + pileta), bento (galeria-01 en el bloque grande),
  y el preview de WhatsApp con un link a `https://mdqclio.github.io/puertodelfin/`.

## Notas

- `optimize_images.sh` recorre `fotos/*.jpg`; ahora no hay JPG ahí, así que no hace nada.
  Lo dejé como está: no forma parte del pedido y no rompe nada. Si querés lo borro o lo
  adapto para leer del staging.
- Los originales siguen en `~/staging-fotos/` (fuera del repo). No los toqué.
- `docs/auditoria/puertodelfin.md` sigue sin trackear; no lo incluí en ningún commit.

## Addendum (mismo día) — hero revertido al anterior

Por pedido de Leonardo, el hero vuelve a ser la foto anterior (`IMG_0399.jpg`, 1179×1446,
las Casas de Mar desde el parque). Recuperada con `git show d52ddc9~1:fotos/IMG_0399.jpg`,
convertida a `fotos/webp/hero.webp` (cwebp q78, sin metadata, 186 KB) pisando la de
cabana-10. `og-image.jpg` regenerado desde este hero (franja y 380–999, 1179×619 → 1200×630,
escala ≈1:1, 149 KB). `<img>` del hero con `width="1179" height="1446"` y el alt anterior.
Ninguna otra foto ni el JSON-LD (más allá de que `"image"` sigue apuntando a `hero.webp` y
`og-image.jpg`, que cambiaron de contenido, no de ruta) fueron tocados. La foto de cabana-10
(`…22-11-04`) queda fuera de la web.
