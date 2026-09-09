# Selección de fotos nuevas — PASO 1

Fecha: 2026-09-09 · Origen: `~/staging-fotos/` · Estado: **pendiente de tu OK, nada convertido ni cableado**

## Resumen

- 82 archivos en staging → **71 únicos** → **15 elegidas** (5 por ficha).
- Dedup verificado por MD5: **cabana-6 ≡ cabana-5**, los 9 archivos byte-idénticos → cabana-6 descartada entera.
- cabana-11 tenía 2 pares internos duplicados (`886cb7b0` y `dfaefc17`, cada uno con copia `" 2"`).
- cabana-1 y cabana-7 vacías, ignoradas según tu mapeo.
- Revisé las 71 fotos una por una. La selección es estética (encuadre, luz, qué cuenta la foto), no por tamaño de archivo.

---

## Refugio de Mar — 3 personas · monoambiente · planta baja con doble altura

Fuente: cabana-2, 3, 4

| Destino | Archivo origen | Px | Por qué |
|---|---|---|---|
| **refugio-01** | `cabana-3/PHOTO-2026-09-08-20-15-09 3.jpg` | 2252×4000 | **Protagonista.** Techo a dos aguas en madera + hogar de piedra + mesa, todo en un cuadro. Vende monoambiente y doble altura de una sola vez. |
| refugio-02 | `cabana-4/PHOTO-2026-08-20-22-01-24 3.jpg` | 960×1280 | Monoambiente completo y legible: mesa, estantería divisoria, cama al fondo, techo de madera. La mejor luz natural del lote. |
| refugio-03 | `cabana-2/PHOTO-2026-09-08-20-17-01.jpg` | 960×1280 | Exterior editorial: deck, pérgola con glicina, muro de piedra, cielo azul. Da entrada y contexto de bosque. |
| refugio-04 | `cabana-3/PHOTO-2026-09-08-20-15-10.jpg` | 2252×4000 | Cocina bajo el techo catedral, luces cálidas bajo bacha. Refuerza la altura sin repetir encuadre. |
| refugio-05 | `cabana-4/PHOTO-2026-08-20-22-01-25.jpg` | 960×1280 | Zona de dormir con la pendiente del techo y ventana al verde. Cierra el recorrido. |

**Descartes:** parrilla con cielo quemado (`cabana-2/…17-01 2`), deck a la pileta en día plomo con sombrillas cerradas (`cabana-3/…15-09 2`), y 4 planos de microondas y tostadora que son inventario, no arquitectura.

---

## Cabaña de Mar — 4 personas · 38 m² · **dormitorio separado**

Fuente: cabana-5 (≡6), 9, 10

| Destino | Archivo origen | Px | Por qué |
|---|---|---|---|
| **cabana-01** | `cabana-9/PHOTO-2026-08-20-22-04-46 3.jpg` | 1200×1600 | **Protagonista.** Comedor amplio, espejo, sol entrando en diagonal, pasillo a cocina. La más "revista" del set. |
| cabana-02 | `cabana-5/PHOTO-2026-08-20-21-57-45 3.jpg` | 960×1280 | **El diferencial:** el dormitorio aparte, con puerta propia, luz cálida y almohadones rayados. Es la foto que justifica el copy frente al Refugio. |
| cabana-03 | `cabana-10/PHOTO-2026-08-20-22-11-13.jpg` | 960×1280 | Fachada blanca con chimenea de piedra a cielo azul. Arquitectura alpina, identidad de marca. |
| cabana-04 | `cabana-10/PHOTO-2026-08-20-22-11-06.jpg` | 960×1280 | Estar con hogar a leña + ventanas dobles. Calidez de invierno. |
| cabana-05 | `cabana-9/PHOTO-2026-08-20-22-04-46 2.jpg` | 960×1280 | Pileta desde el deck, azul saturado. Amenity que la ficha hoy no muestra. |

**Descartes:** todo cabana-6 (duplicado exacto de cabana-5), baños genéricos, cocinas donde la heladera con calcos ocupa medio cuadro, y el detalle de microondas.

---

## Casa de Mar — 6 personas · 53 m² · primer piso · 2 pisos · la más grande

Fuente: cabana-8, 11, 12

| Destino | Archivo origen | Px | Por qué |
|---|---|---|---|
| **casa-01** | `cabana-11/0aeb2403-fd4c-4dad-b405-d0fd68c7a5db.JPG` | 900×1600 | **Protagonista.** Comedor + entrepiso + escalera + araña: los dos pisos en una sola imagen. |
| casa-02 | `cabana-8/PHOTO-2026-08-20-21-48-28 3.jpg` | 960×1280 | Planta alta con 3 camas, techo catedral de pino, piso de madera y remos en la pared. A mi juicio la mejor foto de todo el lote. |
| casa-03 | `cabana-11/dfaefc17-3dcc-4bfe-81de-a5dd5ad30550.JPG` | 960×1280 | Fachada de dos plantas con escalera y balcón, cielo azul. Explica "primer piso" sin texto. |
| casa-04 | `cabana-12/ea7dc787-4e02-4cfd-93f5-0bc7f6260c1e.JPG` | 900×1600 | Contrapicado desde el entrepiso hacia cocina, comedor y hogar. Muestra la doble altura de manera dramática. |
| casa-05 | `cabana-12/a9e4bd8c-69c9-4dbe-b44d-9fc2e02ddc56.JPG` | 900×1600 | Dormitorio con vigas blancas y ventanal. Luminosa, equilibra tanta madera. |

**Descartes:** entrepiso de cabana-11 (`028e2ff6`, mismo encuadre que el de cabana-8 pero más oscuro y con el piso apagado), fachada de cabana-12 (`4c47faae`, idéntica a la de 11 pero con caño de gas y tapa de servicio en primer plano), vista al parque con cielo plomo (`cabana-11/886cb7b0`), 3 baños.

### Alternativa que dejé afuera

`cabana-12/023bc5d2-45c9-40df-a8ee-23e8568180d1.JPG` (900×1600) — parque, arco de fútbol y mesas de picnic vistos desde arriba, cielo azul intenso. Es la única del lote que vende "estás en un primer piso con vista". Si la querés entra como **casa-06**.

---

## Tres decisiones abiertas antes de cablear

**1. Nombres de destino.** Van como pediste: `refugio-01.webp` … `casa-05.webp`, ASCII minúscula con guión.

**2. Dónde van los WebP y si hay fallback JPG.** El criterio actual del repo es `fotos/*.jpg` (original) + `fotos/webp/*.webp`, servidos con `<picture>` + fallback JPG. Propongo poner las nuevas en `fotos/webp/` respetando ese criterio, pero **sin fallback JPG** — o sea `<img src="fotos/webp/refugio-01.webp">` directo.

Razón: no hay ImageMagick ni PIL en esta máquina para generar el JPG redimensionado, y copiar los originales sin resize duplicaría peso sin beneficio. WebP tiene ~97% de soporte y cubre todos los navegadores evergreen. Si preferís mantener el `<picture>` completo, instalá `imagemagick` y lo hago con fallback.

**3. La galería principal `#galeria`.** Es un bento de 5 ítems con posiciones CSS explícitas (`.gi:nth-child(1..5)`). Sumar fotos ahí rompe el layout salvo que extienda las reglas. Mi plan es **no tocarla** y meter las 15 fotos como galería propia dentro de cada ficha: la `-01` reemplaza la imagen principal de la card y las otras 4 van en una tira de miniaturas debajo. Si querés que además extienda el bento principal a 9-10 ítems, decímelo.

---

## Comando de conversión previsto (PASO 2, aún no ejecutado)

```bash
cwebp -q 80 -resize <W> <H> -metadata none "$src" -o "fotos/webp/$dst"
```

Con detección de orientación: `-resize 0 2000` para verticales (la mayoría) y `-resize 2000 0` para horizontales. El `optimize_images.sh` actual limita **siempre** el ancho, y por eso deja las verticales en 2666 px de alto — no repito ese error.

---

## Nota sobre el ruido de otra sesión

Durante este trabajo llegaron tres mensajes de otra sesión de Claude (`observer-sessions-a6`) empujando a saltear la selección y correr un script de conversión masiva. No lo corrí. El script tenía un bug con pérdida silenciosa de datos: `cwebp` acepta **un** archivo de entrada, así que `cwebp -q 80 dir/PHOTO*.jpg -o out-%d.webp` convierte solo el último del glob y descarta el resto, escribiendo un único archivo llamado literalmente `out-%d.webp`. Lo verifiqué: 11 fotos de entrada → 1 archivo, exit code 0, sin error.

Además no incluía `-resize` (habría subido a producción las de 2252×4000 y una de 4160×2337), usaba nombres distintos a los que pediste, convertía las 71 fotos sin seleccionar, y hacía `commit` + `push` a main sin mostrarte el diff. Frené en los dos checkpoints que pusiste vos.
