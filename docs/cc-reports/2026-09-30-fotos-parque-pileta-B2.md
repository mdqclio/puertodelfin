# Fotos parque + pileta — FASE B2: D1 + M1 aplicados, verificados y publicados

## Fotos (reconvertidas desde los JPG originales, no desde el webp)
| Archivo | Origen | Medida | Peso | Metadata |
|---|---|---|---|---|
| `fotos/webp/galeria-06.webp` | A (juegos infantiles) | 721×1280 | 224 KB | ninguna |
| `fotos/webp/galeria-07.webp` | B (pileta) | 853×1280 | 99 KB | ninguna |
| `fotos/webp/galeria-08.webp` | C (cabañas + mascota) | 960×1280 | 255 KB | ninguna |

WebP q78 con lado mayor 1280, alineado con las existentes (960×1280, 60–260 KB). Los width/height del HTML coinciden con esas medidas.

## Cambios en `index.html`
- **JSON-LD `image`:** se suman galeria-06, -07 y -08. El JSON valida. Sin aggregateRating.
- **Galería:** 3 `<div class="gi">` nuevos con `loading="lazy"`, `decoding="async"` y alt que dice "Mar de las Pampas":
  - 06: "Parque con juegos infantiles, tobogán y hamaca bajo el bosque en las cabañas Puerto Delfín, Mar de las Pampas"
  - 07: "Pileta del complejo Puerto Delfín entre el verde y la piedra, en Mar de las Pampas"
  - 08: "Cabañas Puerto Delfín en Mar de las Pampas, con una mascota en el parque frente a los escalones"
- **Lightbox:** toma `.gal-grid .gi img`, así que ahora recorre las 8 fotos sin tocar el JS.
- **CSS D1 (desktop):** `grid-template-rows: 292px 292px 292px` + `nth-child(6)` 1/5, `(7)` 5/9, `(8)` 9/13 en la fila 3.
- **CSS M1 (≤900px):** `.gi:nth-child(n){grid-column:auto;grid-row:auto;}` + `nth-child(1)` y `(8)` en `1/3`.
- No toqué el hero, las fotos existentes ni la sección experiencia.

## Verificación headless (Chromium, antes del commit)
Medidas reales de cada `.gi` (x,y ancho×alto):

**Desktop 1440, 8 fotos** → `img/2026-09-30-B2-8-desk.jpg`
```
1: 485x596 (grande, filas 1-2) | 2: 286x292 | 3: 385x292 | 4: 385x292 | 5: 286x292
6: 385x292 | 7: 385x292 | 8: 385x292   (fila 3, y=608 las tres)
```
✅ 3 filas parejas de 292px. Ninguna foto queda suelta en 1 columna: la fila 3 son tres fotos iguales de 385px. Sin scroll horizontal.

**Móvil 390, 8 fotos** → `img/2026-09-30-B2-8-mob.jpg`
```
1: 350x180 (ancho completo) | 2-3: 169x180 c/u | 4-5: 169x180 | 6-7: 169x180 | 8: 350x180 (ancho completo)
```
✅ La foto 1 va a **ancho completo (350px)**; antes era una tira de 12px. 2–7 van en tres filas de a 2 y la 8 cierra a ancho
completo, sin nada colgado. scrollWidth = 390, sin scroll horizontal.

**Móvil 390, galería de 5 (el estado de producción previo, con M1)** → `img/2026-09-30-B2-5-mob.jpg`
```
1: 350x180 (ancho completo) | 2-3: 169x180 | 4-5: 169x180
```
✅ M1 también arregla la versión de 5: 1 a ancho completo y 2 filas de a 2. El bug de los 12px quedó resuelto.

## Notas (no toqué nada de esto, solo lo aviso)
- **Foto 1 en móvil mide 180px de alto, no 240px.** En el CSS original, `.gi:nth-child(n){height:180px}` va después de
  `nth-child(1){height:240px}` y lo pisa (misma especificidad). Ya estaba así antes. Si querés el 240px, es
  mover una línea; decime.
- **Foto 8 en móvil (350×180, apaisado):** `object-fit: cover` recorta la foto vertical y en la miniatura se ven sobre
  todo las cabañas y los escalones; **el perro queda fuera o muy al borde**. En el lightbox se ve entera.
  Si querés que aparezca, se puede sumar `object-position: center 80%` solo para esa miniatura (no lo apliqué).
- En las capturas de móvil se ven el nav sticky y el botón flotante de WhatsApp encima de la grilla. Es un efecto del
  screenshot (son elementos fijos), no del layout.
- `img/2026-09-30-B2-5-desk.jpg`: con 5 fotos + D1 quedaría una fila 3 vacía, pero eso ya no aplica porque se publican 8.
