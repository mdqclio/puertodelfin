# Fotos parque + pileta — FASE A (propuesta, sin cablear)

Origen: `~/staging-fotos/extra-parque-pileta/` (3 .JPG, sin tag EXIF de orientación → medidas reales).

## 1. Dimensiones

| # | Archivo | Tamaño | Orientación | ¿≥1200 ancho? |
|---|---|---|---|---|
| A | `6f6defdc-….JPG` | 2252×4000 | vertical | ✅ |
| B | `7e5e2be0-….JPG` | 2773×4160 | vertical | ✅ |
| C | `fa671047-….JPG` | 3000×4000 | vertical | ✅ |

No se descarta ninguna por tamaño. Tras convertir (lado mayor ≤2000): A ≈1126×2000, B ≈1333×2000, C 1500×2000.

## 2. Comparación con lo que ya está

Lo que hay hoy: galería 01–05 (frente de cabaña con chimenea, escalera, deck con mesa, entrepiso, dormitorio),
experiencia (parque con mesas de picnic, vista alta) y hero (dron: pileta y cabañas desde arriba).
**La pileta solo aparece en el hero, vista desde arriba. No hay ninguna foto a nivel del suelo, y tampoco de juegos infantiles.**

| Foto | Qué muestra | ¿Aporta algo nuevo? | Destino | Por qué |
|---|---|---|---|---|
| **A** | Parque con juegos infantiles (tobogán, hamaca, sube y baja), bosque atrás y cielo azul | **Sí.** Primera foto de juegos para chicos; el parque ya aparece en experiencia, pero desde otro ángulo | **galeria-06** | Suma un argumento para familias que hoy la web no muestra. |
| **B** | Pileta detrás de la baranda, con la construcción de piedra y un sendero de piedritas; desenfoque buscado, tono cálido | **Sí.** Es la única pileta a ras del suelo (el texto de experiencia promete "Pileta templada con deck") | **galeria-07** | Muestra la pileta que el texto promete y que hoy solo se ve desde el dron. |
| **C** | Los dos bloques de cabañas vistos desde el parque, escalones en el pasto y un perro echado adelante | **En parte.** galeria-01 ya muestra un frente, pero de cerca; esta da el conjunto y el parque en pendiente | **galeria-08** | Da una idea de la escala del complejo desde el suelo, como complemento del hero. |

### Experiencia
Esa sección tiene **un solo espacio de imagen** (`experiencia.webp`, ya ocupado). Poner B ahí reemplazaría una
foto existente, y eso está fuera del alcance ("NO tocar fotos existentes"). Si en algún momento querés que experiencia
muestre la pileta, B es la candidata; lo dejo solo **anotado**. Por defecto: **las 3 van a galería**.

### Ojo, dos cosas para decidir vos
- **Perro en C:** la web no dice nada de mascotas (no aparece "mascota" en index.html). Si el complejo **no** acepta
  mascotas, la foto puede generar consultas o una expectativa equivocada. Si es el perro de la casa, está bien y hasta
  suma calidez. **Confirmame.**
- **Juegos en A:** la web tampoco menciona juegos para chicos. La foto funciona igual, y en el alt los nombraría
  ("con juegos infantiles").
- B tiene el primer plano de follaje oscuro y la pileta desenfocada a propósito. Sirve para la galería; no la usaría como imagen principal.

## 3. ¿Alguna sirve de hero?
**No.** Las tres son **verticales**. Ninguna reemplaza al frame de dron apaisado de 1619×972, que además muestra
mar, pileta y cabañas juntos. No toco el hero.

## Plan FASE B (cuando des el OK)
- WebP q78, lado mayor ≤2000, sin metadata → `fotos/webp/galeria-06.webp` (A), `-07` (B), `-08` (C).
- `<div class="gi">` con width/height reales, `loading="lazy"`, `decoding="async"`, alt en español con "Mar de las Pampas". Borradores:
  - 06: "Parque con juegos infantiles y bosque en las cabañas Puerto Delfín, Mar de las Pampas"
  - 07: "Pileta del complejo Puerto Delfín entre el verde y la piedra, en Mar de las Pampas"
  - 08: "Cabañas Puerto Delfín vistas desde el parque en Mar de las Pampas"
- El lightbox ya toma todos los `.gi` de #galeria, así que las nuevas quedarían incluidas sin tocar JS (lo verifico en B).
- JSON-LD: solo sumar las nuevas URLs al array `image`. Sin aggregateRating. Hero, fotos existentes y experiencia: sin tocar.
