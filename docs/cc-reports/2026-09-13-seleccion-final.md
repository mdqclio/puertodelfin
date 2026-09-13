# Selección FINAL de fotos — FASE A (propuesta)

Fecha: 2026-09-13 · Pool: 70 rutas curadas por los dueños · Estado: **propuesta, nada convertido ni cableado**

Vi las 70 fotos del pool una por una. Todo lo que está fuera del pool quedó excluido.
Dimensiones verificadas leyendo el header JPEG (ninguna tiene EXIF de rotación, así que
lo que dice el archivo es lo que se ve).

## Lo primero: el hero

**En el pool no hay ninguna foto apaisada que sirva de hero.** De las 70, la única
horizontal es `cabana-3/PHOTO-2026-09-08-20-15-10 3.jpg` (4160×2337) y es un **baño**.
Las 3 GALERÍA son verticales (960×1280).

Entonces el hero sale del pool y es vertical, como el hero actual (`IMG_0399.jpg`,
1179×1446). El CSS ya lo resuelve: `.hero-bg img { object-fit: cover; object-position: center 30% }`.
En desktop 1920×1080 se ve la franja central del 30 % hacia abajo; en celular entra la
foto vertical casi completa. Elegí la foto por cómo queda **esa franja**, no la foto entera.

| Destino | Origen | Px | Por qué |
|---|---|---|---|
| **hero.webp** | `cabana-10/PHOTO-2026-08-20-22-11-04.jpg` | 960×1280 V | Deck con mesa, baranda negra, pileta azul, casa blanca de chimenea y bosque bajo cielo azul limpio. Es la única del pool que junta en un cuadro las cuatro cosas que vendemos: deck, pileta, bosque, cabaña. La franja central (cielo→casa→pileta→baranda) es exactamente lo que se ve en desktop; el deck oscuro abajo queda debajo del texto en celular. |

Alternativas si no te convence (las digo para que decidas, no las recomiendo):
- `cabana-3/PHOTO-2026-09-08-20-15-09 2.jpg` (2252×4000): deck → pileta → casa de dos plantas. Es la única con resolución para un **recorte apaisado real** (2252×1267), pero el cielo es plomo y las sombrillas están cerradas. Mata el "abierto todo el año".
- `cabana-12/023bc5d2-…JPG` (900×1600): parque con cielo azul intenso. Muy linda, pero el 50 % de arriba es cielo vacío y con el recorte de desktop queda mitad cielo, mitad copas. La uso en Experiencia.
- `cabana-10/PHOTO-2026-08-20-22-11-13.jpg` (GALERÍA, fachada con chimenea): aguanta, pero en la franja de desktop queda pared blanca + ventanas y pierde la chimenea completa que es lo que la hace linda. Mejor en el bento, en el bloque grande vertical.

**OG image (1200×630):** recorte apaisado de la franja central del hero (y≈250–754 de la
original, 960×504) escalado a 1200×630. Es un upscale de 1,25× — aceptable para un
preview de WhatsApp/Facebook. Ojo: en esta máquina no hay ImageMagick ni PIL ni cjpeg;
para generar el JPG en Fase B uso `uv run --with pillow` (uv está instalado).

---

## Refugio de Mar (3p) — cabana-2, 3, 4

| Destino | Origen | Px → final | Orient. | Por qué |
|---|---|---|---|---|
| **refugio-01** | `cabana-4/PHOTO-2026-08-20-22-01-25 3.jpg` | 960×1280 | V | **Protagonista.** Hogar de piedra, techo catedral con vigas, mesa blanca, cama de un cuerpo, estantería divisoria: todo el monoambiente en un cuadro y con luz. En el recorte cuadrado de la card (320 px de alto) entra desde las vigas hasta la mesa. |
| refugio-02 | `cabana-3/PHOTO-2026-09-08-20-15-10 2.jpg` | 2252×4000 → 1126×2000 | V | Comedor + cama + estantería bajo el techo a dos aguas, ventanas con verde. Mismo ambiente, otro ángulo, luz natural. La más nítida del lote. |
| refugio-03 | `cabana-2/PHOTO-2026-09-08-20-17-01.jpg` | 960×1280 | V | Exterior: deck negro, pérgola con glicina, muro de piedra, puerta con el 2, cielo azul. Da entrada y contexto de bosque. |
| refugio-04 | `cabana-3/PHOTO-2026-09-08-20-15-10.jpg` | 2252×4000 → 1126×2000 | V | Cocina completa bajo la cumbrera, luces cálidas bajo alacena. Muestra la altura sin repetir el hogar. |
| refugio-05 | `cabana-4/PHOTO-2026-08-20-22-01-25.jpg` | 960×1280 | V | Cama matrimonial con la pendiente del techo y ventana al verde. Cierra: dónde dormís. |

Cambio respecto de lo que está en producción: cambia la protagonista (antes `cabana-3/…15-09 3`,
hogar + fan + puerta con cortina; la nueva es más limpia y más luminosa) y refugio-02 pasa de la
de cabana-4 a la de cabana-3 (más resolución, misma idea).

Descartes: 3 baños, 4 planos de microondas/tostadora/cocina chica, la toalla con logo
(`…17-03 4`, linda para IG, no para una ficha), la parrilla con cielo quemado (`…17-01 2`),
el deck de cabaña 4 con vista al parque (`…01-24 2`) que **rescato para la galería**.

---

## Cabaña de Mar (4p) — cabana-5, 9, 10

| Destino | Origen | Px → final | Orient. | Por qué |
|---|---|---|---|---|
| **cabana-01** | `cabana-9/PHOTO-2026-08-20-22-04-46 3.jpg` | 1200×1600 | V | **Protagonista.** Comedor de 6 sillas, espejo grande, sol entrando en diagonal por el piso, pasillo a la cocina. La más "revista" del set y la de mayor resolución. |
| cabana-02 | `cabana-5/PHOTO-2026-08-20-21-57-45 3.jpg` | 960×1280 | V | **El diferencial:** dormitorio aparte, cama matrimonial, almohadones rayados, ventana al verde. Es la foto que justifica el copy "dormitorio separado". |
| cabana-03 | `cabana-5/PHOTO-2026-08-20-21-57-43 2.jpg` | 960×1280 | V | Deck propio: mesa, sillones azules, muro de piedra, bosque y cielo. Exterior sin repetir la fachada (que va en galería) ni el hero. |
| cabana-04 | `cabana-10/PHOTO-2026-08-20-22-11-06.jpg` | 960×1280 | V | Estar con hogar de piedra, TV, ventanas dobles, puerta vidriada que deja ver la pileta. Calidez de invierno. |
| cabana-05 | `cabana-5/PHOTO-2026-08-20-21-57-44 3.jpg` | 960×1280 | V | Cocina: la única de las tres cabañas donde la heladera no se come el cuadro. Anafe, bacha, reloj, piso. Completa la variedad. |

Cambio respecto de producción: cabana-03 (antes la fachada `…11-13`, que ahora es GALERÍA)
y cabana-05 (antes la pileta desde el deck `cabana-9/…46 2`, que **no está en el pool**).

Alternativa que dejé afuera: `cabana-10/PHOTO-2026-08-20-22-11-08.jpg` (cama de una plaza,
reloj, dos ventanas, sol) — muy linda, cuenta "cuarta cama". Si preferís belleza a variedad,
reemplaza a cabana-05.

Descartes: 3 baños, microondas, 2 cocinas con heladera en primer plano, la cama con espejo
de cabana-9 (`…47 2`, casi igual a `…11-15` de cabana-10 y esa tampoco entra por espacio).

---

## Casa de Mar (6p) — cabana-8, 11, 12

| Destino | Origen | Px → final | Orient. | Por qué |
|---|---|---|---|---|
| **casa-01** | `cabana-11/0aeb2403-fd4c-4dad-b405-d0fd68c7a5db.JPG` | 900×1600 | V | **Protagonista.** Comedor, entrepiso con baranda, escalera y araña encendida: los dos pisos en una imagen. En el recorte de la card entra araña → baranda → mesa. |
| casa-02 | `cabana-8/PHOTO-2026-08-20-21-48-28 3.jpg` | 960×1280 | V | Entrepiso con 3 camas, techo catedral de pino, piso de madera, remos cruzados. Sigue siendo la mejor foto de todo el lote. |
| casa-03 | `cabana-11/dfaefc17-3dcc-4bfe-81de-a5dd5ad30550 2.JPG` | 960×1280 | V | Fachada de dos plantas con escalera y balcón, cielo azul. Explica "primer piso" sin texto. (La de cabana-12 `4c47faae` es la misma fachada con caño de gas y tapa de servicio adelante.) |
| casa-04 | `cabana-12/ea7dc787-4e02-4cfd-93f5-0bc7f6260c1e.JPG` | 900×1600 | V | Contrapicado desde el entrepiso: cocina, comedor, hogar y cuadro del mar. La doble altura, dramática. |
| casa-05 | `cabana-11/3e6a1537-384c-42a9-bd9b-d9c839a6c8ee.JPG` | 900×1600 | V | Dormitorio matrimonial con respaldo rayado, vigas blancas y ventana al verde. Luminosa, equilibra tanta madera. |

Cambio respecto de producción: casa-05 (antes `cabana-12/a9e4bd8c`, **no está en el pool**;
`3e6a` es el mismo dormitorio con el respaldo rayado a la vista) y **desaparece casa-06**
(el parque `023bc5d2`), que pasa a Experiencia.

Descartes: 3 baños, entrepiso de cabana-11 (`028e2ff6`, mismo encuadre que casa-02 pero más
oscuro y con ventilador), dormitorio con TV y cables (`81b5b7dd`), escalera de cabana-12
(`2423b6d2`, igual a la de cabana-8 pero con menos luz), comedor de cabana-12 (`054ce22c`,
casi calcado a casa-01), cocina con araña (`1ca2ed96`, buena pero es la sexta y no hay lugar).

---

## Espacios generales (7)

| Destino | Origen | Px → final | Orient. | Dónde / por qué |
|---|---|---|---|---|
| **hero.webp** | `cabana-10/PHOTO-2026-08-20-22-11-04.jpg` | 960×1280 | V | Hero (ver arriba). **Del pool, no de las GALERÍA.** |
| galeria-01 | `cabana-10/PHOTO-2026-08-20-22-11-13.jpg` | 960×1280 | V | **GALERÍA.** Bloque grande del bento (5 col × 2 filas, casi vertical): fachada blanca con la chimenea de piedra completa, puerta con el 10, cielo azul. Identidad de marca. |
| galeria-02 | `cabana-5/PHOTO-2026-08-20-21-57-43.jpg` | 960×1280 | V | **GALERÍA.** Bloque chico cuadrado: escalera negra a la cabaña 6 entre formios y laurel, luz de tarde. El recorte central deja escalera + puerta. |
| galeria-03 | `cabana-4/PHOTO-2026-08-20-22-01-24 2.jpg` | 960×1280 | V | Del pool. Bloque 4 col × 1 fila: deck en altura con mesa y sillas azules mirando al parque y al bosque, cielo azul. No está en ninguna ficha; es la única "vista desde arriba" del lote. |
| galeria-04 | `cabana-8/PHOTO-2026-08-20-21-48-28 3.jpg` | 960×1280 | V | Del pool, **repite casa-02** (el entrepiso con remos). Bloque 4 col × 1 fila: el recorte central deja camas + remos + vigas. Es la foto más fuerte que tenemos; merece verse suelta. |
| galeria-05 | `cabana-10/PHOTO-2026-08-20-22-11-08 2.jpg` | 960×1280 | V | **GALERÍA.** Bloque chico cuadrado: dormitorio con toallas bordadas y la ventana abierta a la escalera del vecino. Cierra el bento con un interior cálido. |
| **experiencia.webp** | `cabana-12/023bc5d2-45c9-40df-a8ee-23e8568180d1.JPG` | 900×1600 | V | Parque desde arriba: césped, mesas de picnic, arco de fútbol, palmeras y cipreses bajo cielo azul. Es "la experiencia" literal (mañanas, verde, silencio). Reemplaza a `IMG_0389` (parque + parrilla, cielo lavado). |

Alternativa para experiencia: `cabana-11/886cb7b0-… 2.JPG` (mismo parque desde el balcón,
más cerca de las mesas, pero cielo plomo). Alternativa para galeria-04 si no querés repetir:
`cabana-2/PHOTO-2026-09-08-20-17-01.jpg` (repetiría refugio-03) o
`cabana-3/PHOTO-2026-09-08-20-15-09.jpg` (frente de la cabaña 3, cielo azul, no está en
ninguna ficha, pero tiene el matafuegos rojo al lado de la puerta).

---

## Resumen de archivos

**Origen → destino (22 conversiones, todas verticales):**

```
cabana-4/PHOTO-2026-08-20-22-01-25 3.jpg                → fotos/webp/refugio-01.webp   960×1280
cabana-3/PHOTO-2026-09-08-20-15-10 2.jpg                → fotos/webp/refugio-02.webp   1126×2000
cabana-2/PHOTO-2026-09-08-20-17-01.jpg                  → fotos/webp/refugio-03.webp   960×1280
cabana-3/PHOTO-2026-09-08-20-15-10.jpg                  → fotos/webp/refugio-04.webp   1126×2000
cabana-4/PHOTO-2026-08-20-22-01-25.jpg                  → fotos/webp/refugio-05.webp   960×1280
cabana-9/PHOTO-2026-08-20-22-04-46 3.jpg                → fotos/webp/cabana-01.webp    1200×1600
cabana-5/PHOTO-2026-08-20-21-57-45 3.jpg                → fotos/webp/cabana-02.webp    960×1280
cabana-5/PHOTO-2026-08-20-21-57-43 2.jpg                → fotos/webp/cabana-03.webp    960×1280
cabana-10/PHOTO-2026-08-20-22-11-06.jpg                 → fotos/webp/cabana-04.webp    960×1280
cabana-5/PHOTO-2026-08-20-21-57-44 3.jpg                → fotos/webp/cabana-05.webp    960×1280
cabana-11/0aeb2403-fd4c-4dad-b405-d0fd68c7a5db.JPG      → fotos/webp/casa-01.webp      900×1600
cabana-8/PHOTO-2026-08-20-21-48-28 3.jpg                → fotos/webp/casa-02.webp      960×1280
cabana-11/dfaefc17-3dcc-4bfe-81de-a5dd5ad30550 2.JPG    → fotos/webp/casa-03.webp      960×1280
cabana-12/ea7dc787-4e02-4cfd-93f5-0bc7f6260c1e.JPG      → fotos/webp/casa-04.webp      900×1600
cabana-11/3e6a1537-384c-42a9-bd9b-d9c839a6c8ee.JPG      → fotos/webp/casa-05.webp      900×1600
cabana-10/PHOTO-2026-08-20-22-11-04.jpg                 → fotos/webp/hero.webp         960×1280
cabana-10/PHOTO-2026-08-20-22-11-13.jpg                 → fotos/webp/galeria-01.webp   960×1280
cabana-5/PHOTO-2026-08-20-21-57-43.jpg                  → fotos/webp/galeria-02.webp   960×1280
cabana-4/PHOTO-2026-08-20-22-01-24 2.jpg                → fotos/webp/galeria-03.webp   960×1280
cabana-8/PHOTO-2026-08-20-21-48-28 3.jpg                → fotos/webp/galeria-04.webp   960×1280  (mismo origen que casa-02)
cabana-10/PHOTO-2026-08-20-22-11-08 2.jpg               → fotos/webp/galeria-05.webp   960×1280
cabana-12/023bc5d2-45c9-40df-a8ee-23e8568180d1.JPG      → fotos/webp/experiencia.webp  900×1600
hero (recorte central 960×504 → 1200×630)               → og-image.jpg                 1200×630 H
```

Sobre el pool: 21 archivos distintos usados de 70. No hay ninguna con lado mayor >2000 salvo
las 4 de cabana-3 (2252×4000) que van a 1126×2000; el resto se convierte a tamaño nativo.
Todas con `cwebp -q 78 -metadata none` (`-resize 0 2000` solo en las de cabana-3).

**Se borran en Fase B:** `fotos/IMG_0386…0399.jpg` (12) + `fotos/webp/IMG_*.webp` (12) +
`fotos/webp/casa-06.webp`. Los 15 `refugio/cabana/casa-0x.webp` actuales se sobreescriben.

**HTML que se toca en Fase B:** hero (`<picture>` → `<img>` webp directo), preload, og:image,
og:image:width/height ya están en 1200×630, twitter:image, `"image"` del JSON-LD (las 3
URLs pasan a `og-image.jpg` + `hero.webp` + `galeria-01.webp`, o solo `og-image.jpg` — lo
defino cuando cablee y lo aviso en el diff), las 3 fichas, `#galeria` (5 `.gi`, mismo
layout), Experiencia. Los `width`/`height` se ponen con los px finales reales.

---

## Tres cosas para que confirmes con el OK

1. **Hero vertical del pool** (`cabana-10/…11-04`), no de las GALERÍA. Si preferís una GALERÍA
   igual, la que mejor aguanta es la fachada `…11-13`; en ese caso saco esa del bento y la
   reemplazo por `cabana-3/…15-09.jpg` (frente cabaña 3).
2. **galeria-04 repite casa-02** (entrepiso con remos). Si no querés repetir, digo con qué.
3. **refugio-01 cambia** respecto de lo que hoy está en producción (pasa de la de cabana-3 a
   la de cabana-4 con hogar de piedra). Si preferís mantener la actual, `…15-09 3` está en el
   pool y la dejo.

Con tu OK arranco Fase B.
