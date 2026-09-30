# Fotos parque + pileta — FASE B: FRENADA antes del commit (el grid se rompe)

**Estado:** las fotos están convertidas y cableadas **en local, sin commitear**. Solo commiteo este reporte y las capturas.
Frené como pediste: con 8 fotos el bento queda feo en desktop, y en móvil ya estaba roto desde antes.

## Lo que está hecho (local, sin commit)
| Archivo | Origen | Medida | Peso | Metadata |
|---|---|---|---|---|
| `fotos/webp/galeria-06.webp` | A (juegos) | 1126×2000 | 483 KB | ninguna |
| `fotos/webp/galeria-07.webp` | B (pileta) | 1333×2000 | 213 KB | ninguna |
| `fotos/webp/galeria-08.webp` | C (cabañas + perro) | 1500×2000 | 601 KB | ninguna |

WebP q78, lado mayor 2000. Las existentes miden 960×1280 y pesan entre 60 y 260 KB; las nuevas pesan bastante más.
Si querés alinearlas, puedo bajarlas a 1280 de lado mayor (quedarían en un tercio del peso aprox.).

Diff de `index.html` (sin commit):
```diff
   "image": [
     ".../og-image.jpg",
     ".../fotos/webp/hero.webp",
-    ".../fotos/webp/galeria-01.webp"
+    ".../fotos/webp/galeria-01.webp",
+    ".../fotos/webp/galeria-06.webp",
+    ".../fotos/webp/galeria-07.webp",
+    ".../fotos/webp/galeria-08.webp"
   ],
...
+ <div class="gi"><img src="fotos/webp/galeria-06.webp" alt="Parque con juegos infantiles, tobogán y hamaca bajo el bosque en las cabañas Puerto Delfín, Mar de las Pampas" width="1126" height="2000" loading="lazy" decoding="async"></div>
+ <div class="gi"><img src="fotos/webp/galeria-07.webp" alt="Pileta del complejo Puerto Delfín entre el verde y la piedra, en Mar de las Pampas" width="1333" height="2000" loading="lazy" decoding="async"></div>
+ <div class="gi"><img src="fotos/webp/galeria-08.webp" alt="Cabañas Puerto Delfín en Mar de las Pampas, con una mascota en el parque frente a los escalones" width="1500" height="2000" loading="lazy" decoding="async"></div>
```
El JSON-LD valida. El lightbox toma `.gal-grid .gi img`, así que las 3 nuevas entran solas. No toqué el hero, las
fotos existentes, la sección experiencia ni aggregateRating.

## Por qué se rompe
El bento tiene **posiciones fijas para 5 fotos** (`.gi:nth-child(1..5)` en 12 columnas × 2 filas de 292px).

- **Desktop (1440):** las fotos 6, 7 y 8 no tienen regla, así que caen en una 3.ª fila automática, **cada una de 1 columna
  (≈87×155px)**, pegadas a la izquierda y con el resto vacío. Se ve roto. → `img/2026-09-30-B-grid-desk.jpg`
- **Móvil (390): ya estaba roto en producción, antes de este cambio.** Las reglas `nth-child(2..5)` de desktop
  (`grid-column:6/9`, etc.) no se anulan en el media query de ≤900px. Eso crea columnas implícitas, y la foto 1 queda
  en **12px de ancho**, una tira fina a la izquierda. → `img/2026-09-30-B-head-mob.jpg` (producción actual)
  y `img/2026-09-30-B-grid-mob.jpg` (con 8 fotos: las nuevas quedan como tiras de 24px).
- Aunque se arregle esa pérdida de reglas, en móvil queda 1 foto a ancho completo + 7 en 2 columnas, así que **la 8 queda
  sola en la última fila**.

## Opciones (no apliqué ninguna, elegís vos)
**Desktop.** Recomiendo la **D1**, que suma una fila y no toca las 5 posiciones actuales:
```css
.gal-grid { grid-template-rows: 292px 292px 292px; }
.gi:nth-child(6){grid-column:1/5;grid-row:3/4;}
.gi:nth-child(7){grid-column:5/9;grid-row:3/4;}
.gi:nth-child(8){grid-column:9/13;grid-row:3/4;}
```
Quedan 3 fotos iguales en la fila 3, bajo el bento actual. Redistribuir todo el bento ya sería un rediseño, así que no lo propongo.

**Móvil.** Recomiendo la **M1**, que arregla el bug que ya existía y evita la foto colgada:
```css
/* dentro de @media(max-width:900px), antes de nth-child(1) */
.gi:nth-child(n){grid-column:auto;grid-row:auto;}
.gi:nth-child(1), .gi:nth-child(8){grid-column:1/3;}
```
Queda así: la 1 a ancho completo, 2–7 en tres filas de a 2, y la 8 a ancho completo cerrando la galería.

## Corrección a la Fase A
En la Fase A dije que "la web no menciona mascotas". **Estaba mal:** mi grep tenía un error de contexto.
La web ya lo dice en el JSON-LD (`petsAllowed`, "Admite mascotas"), en la FAQ, en "🐾 Pet friendly" y en el texto de
equipamiento. El perro en C está bien.

## Para seguir
Decime **"D1 + M1"** (o lo que prefieras) y, si querés, si bajo el peso de las fotos. Aplico el CSS, vuelvo a sacar
capturas de desktop y móvil, y después hago commit + push de todo.
