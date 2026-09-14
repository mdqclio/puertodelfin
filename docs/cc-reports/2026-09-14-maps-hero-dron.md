# Google Maps en JSON-LD + hero nuevo (dron) — 2026-09-14

## 1. Google Maps: el CID autorizado NO era el del iframe

Verifiqué con Chromium headless (curl no sirve: Maps renderiza todo por JS y
desde este servidor pide consentimiento de cookies; lo resolví con cookie SOCS +
Playwright):

| URL | Resuelve a |
|---|---|
| `google.com/maps?cid=9989726431584963514` (el autorizado) | **nada**: mapa vacío centrado en Alemania, `<title>Google Maps</title>`, sin h1 |
| `google.com/maps?cid=9989349349145549754` | **Puerto Delfín**, h1 "Puerto Delfín", dirección "Delfin esquina, Alfonsina Storni, B7165 Mar de las Pampas", URL final `/maps/place/Puerto+Delfín/@-37.3314904,-57.0213963,...!1s0x959b5c2d52a1b1a5:0x8aa14c4ea5199bba...` |

Causa: la conversión hex→decimal del reporte anterior estaba mal.
`0x8aa14c4ea5199bba` (el CID hex del iframe) = **9989349349145549754**, no
…726431584963514 (ese equivale a `0x8aa2a342fdf3cbba`, otro lugar / ninguno).

Decisión: como la autorización era "el derivado del place ID del iframe" y el
derivado correcto verifica al 100 % (mismo hex `0x8aa14c4ea5199bba` en la URL
final de Maps que en el iframe), puse el correcto. Si preferís que no vaya
hasta chequearlo vos, lo saco con un revert de 3 líneas.

Cambios en el JSON-LD LodgingBusiness:
- `sameAs`: + `https://www.google.com/maps?cid=9989349349145549754`
- `hasMap`: `https://www.google.com/maps?cid=9989349349145549754`
- JSON validado (LodgingBusiness + FAQPage parsean OK).

## 2. Hero nuevo (dron)

`~/staging-fotos/hero-dron.jpg` **no existe**. Lo único nuevo en staging es
`Hero.PNG` (subido hoy 03:06, 3,3 MB, PNG RGB 8-bit sin EXIF). Asumí que es el
frame del dron: vista aérea, mar arriba, las dos cabañas blancas al centro,
pileta abajo. Si no era ese archivo, avisame y lo repito.

- **Píxeles del original: 1619 × 972** (apaisado, 1,666:1). Lado mayor ya < 2000
  → sin resize.
- `fotos/webp/hero.webp`: cwebp q78, `-metadata none` (webpinfo: solo chunk
  VP8, sin EXIF/XMP/ICC). 1619×972, **394 KB** (antes 190 KB — la toma aérea
  tiene mucho follaje, comprime peor). Si querés bajarlo, q70 ronda ~300 KB;
  no lo hice porque pediste q78.
- `og-image.jpg` 1200×630: recorte centrado a todo el ancho del original
  (franja y 61–911, 1619×850) y **reducción** a 1200×630 con Lanczos. No se
  agrandó nada. q82 progresivo, 252 KB. Entra el mar, las dos cabañas y la
  pileta.
- `<img>` del hero: `width="1619" height="972"` (antes 1179×1446).
- JSON-LD `image`: sin cambios de rutas (mismos og-image.jpg / hero.webp, solo
  cambió el contenido). No toqué nada más del JSON-LD fuera de lo del punto 1.

### object-position: queda `center 30%` (sin cambio)

Rendericé la página real con Chromium headless en 3 viewports y comparé
`center 30%`, `center 50%` y `45% 50%`:

- **Desktop 1440×900** (1,6:1 vs foto 1,666:1): la foto entra casi entera,
  recorte horizontal mínimo; la posición vertical prácticamente no actúa.
  Se ven mar, cabañas y pileta. El texto cae sobre la cabaña izquierda y el
  techo oscuro de abajo a la izquierda; el degradé lo sostiene bien.
- **Ultra-wide 1920×800** (2,4:1): acá sí recorta vertical (~30 %). Con 30 %
  se conserva la franja de mar arriba (es el argumento "a 50 m del mar") y se
  sacrifica la pileta abajo. Con 50 % se perdía casi todo el mar. Preferí el
  mar.
- **Móvil 390×844**: cover escala por alto, se ve solo el 28 % del ancho; la
  posición vertical no actúa, solo la horizontal. `center` muestra el sendero
  entre las dos cabañas, el mar arriba y la pileta abajo del CTA; `45%` era
  casi igual. `center` queda.

Capturas en el scratchpad de la sesión (no van al repo).

## Verificación
- `git diff --stat`: hero.webp, og-image.jpg, index.html (+4/−2). Ninguna otra
  foto tocada.
- Commit + push a main; HEAD == origin/main.
