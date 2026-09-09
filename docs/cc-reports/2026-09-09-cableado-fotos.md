# Cableado de fotos nuevas — PASO 2 + PASO 3

Fecha: 2026-09-09 · Aprobado por Leonardo: 15 fotos + `casa-06`, nombres acordados, WebP sin fallback JPG, `#galeria` sin tocar.

## PASO 2 — Conversión

16 fotos → `fotos/webp/`. Comando base:

```
cwebp -q 80 -metadata none [-resize …] <origen> -o fotos/webp/<destino>.webp
```

**Resize solo cuando hacía falta.** Guarda explícita para no ampliar: si el lado largo ya era ≤ 2000 px, no se toca. Solo dos archivos superaban el límite.

**Tres archivos bajaron a q=75.** A q=80, `refugio-03`, `cabana-03` y `cabana-05` pesaban **más que el JPEG de origen** (301→289K, 196→202K, 186→188K): son las tres con más follaje, que es lo más caro de comprimir. A q=75 quedan 249K, 172K y 160K. q=75 es además el valor que ya usa `optimize_images.sh` en este repo, así que no introduce un criterio nuevo.

| Destino | Origen | Origen px | WebP px | JPG | WebP | Acción |
|---|---|---|---|---|---|---|
| refugio-01 | `cabana-3/PHOTO-2026-09-08-20-15-09 3.jpg` | 2252×4000 | 1126×2000 | 566K | 169K | resize + q80 |
| refugio-02 | `cabana-4/PHOTO-2026-08-20-22-01-24 3.jpg` | 960×1280 | 960×1280 | 141K | 107K | q80 |
| refugio-03 | `cabana-2/PHOTO-2026-09-08-20-17-01.jpg` | 960×1280 | 960×1280 | 301K | 249K | **q75** |
| refugio-04 | `cabana-3/PHOTO-2026-09-08-20-15-10.jpg` | 2252×4000 | 1126×2000 | 446K | 116K | resize + q80 |
| refugio-05 | `cabana-4/PHOTO-2026-08-20-22-01-25.jpg` | 960×1280 | 960×1280 | 102K | 66K | q80 |
| cabana-01 | `cabana-9/PHOTO-2026-08-20-22-04-46 3.jpg` | 1200×1600 | 1200×1600 | 186K | 107K | q80 |
| cabana-02 | `cabana-5/PHOTO-2026-08-20-21-57-45 3.jpg` | 960×1280 | 960×1280 | 112K | 82K | q80 |
| cabana-03 | `cabana-10/PHOTO-2026-08-20-22-11-13.jpg` | 960×1280 | 960×1280 | 196K | 172K | **q75** |
| cabana-04 | `cabana-10/PHOTO-2026-08-20-22-11-06.jpg` | 960×1280 | 960×1280 | 104K | 82K | q80 |
| cabana-05 | `cabana-9/PHOTO-2026-08-20-22-04-46 2.jpg` | 960×1280 | 960×1280 | 186K | 160K | **q75** |
| casa-01 | `cabana-11/0aeb2403….JPG` | 900×1600 | 900×1600 | 193K | 94K | q80 |
| casa-02 | `cabana-8/PHOTO-2026-08-20-21-48-28 3.jpg` | 960×1280 | 960×1280 | 120K | 80K | q80 |
| casa-03 | `cabana-11/dfaefc17….JPG` | 960×1280 | 960×1280 | 245K | 157K | q80 |
| casa-04 | `cabana-12/ea7dc787….JPG` | 900×1600 | 900×1600 | 213K | 119K | q80 |
| casa-05 | `cabana-12/a9e4bd8c….JPG` | 900×1600 | 900×1600 | 155K | 69K | q80 |
| casa-06 | `cabana-12/023bc5d2….JPG` | 900×1600 | 900×1600 | 235K | 159K | q80 |

Total: 3.4 MB de origen → **2.0 MB** en WebP. Metadata EXIF/GPS eliminada en todas.

## PASO 3 — Cableado en `index.html`

**Estructura por ficha.** La foto `-01` reemplaza la imagen principal de la card; el resto va en una tira de miniaturas debajo. Refugio y Cabaña quedan con 4 miniaturas, Casa con 5.

```html
<div class="cab-img">
  <img src="fotos/webp/refugio-01.webp" alt="…" width="1126" height="2000" loading="lazy" decoding="async">
  <span class="cab-tag">2 – 3 personas</span>
</div>
<div class="cab-thumbs">
  <div class="cab-thumb"><img src="fotos/webp/refugio-02.webp" alt="…" width="960" height="1280" loading="lazy" decoding="async"></div>
  …
</div>
```

**CSS agregado** (4 reglas nuevas + 1 en el media query mobile). `grid-auto-flow: column` para que la tira se adapte sola a 4 o 5 miniaturas sin regla por ficha:

```css
.cab-thumbs { display: grid; grid-auto-flow: column; grid-auto-columns: 1fr; gap: 4px; margin-top: 4px; }
.cab-thumb  { height: 76px; overflow: hidden; cursor: zoom-in; }
.cab-thumb img { filter: saturate(0.95); transition: transform 0.5s, filter 0.5s; }
.cab-thumb:hover img { transform: scale(1.07); filter: brightness(1.03) saturate(1); }
/* mobile */ .cab-thumb { height: 92px; }
```

**Lightbox.** El selector pasó de `.gi` a `.gi, .cab-thumb`: las miniaturas abren el lightbox que ya existía. Un carácter de cambio en el JS, sin lógica nueva — el handler ya hacía `querySelector('img')` y `.cab-thumb` tiene la misma forma que `.gi`.

### Copy reescrito

Los tres textos cambiaron para decir que **cada ficha son cuatro unidades** y para que la diferencia Refugio/Cabaña sea el plano, no la capacidad.

**Refugio de Mar** — antes decía *"38 m² de confort total… Para una pareja que quiere estar en su mundo"*, que no mencionaba ni el monoambiente ni que son cuatro. Ahora:

> Son cuatro cabañas iguales, de 38 m² en planta baja. Funcionan como monoambiente: cocina, living y camas comparten un mismo espacio que se abre hacia arriba, con el techo a dos aguas a la vista y la luz cayendo desde la cumbrera. Hogar a leños, baño con bañera y deck propio con parrilla.

El matiz planta baja / doble altura entra por "se abre hacia arriba", "techo a dos aguas a la vista" y "la luz cayendo desde la cumbrera". No aparece "techo bajo" ni nada que lo sugiera: la frase empuja en la dirección contraria.

**Cabaña de Mar** — el diferencial ahora es explícito y se apoya en `cabana-02`, la foto del dormitorio aparte:

> También son cuatro unidades, y miden los mismos 38 m² que el Refugio. Lo que cambia es el plano: acá el dormitorio es un cuarto aparte, con su puerta, separado del living y la cocina. Duermen cuatro sin que todos tengan que apagar la luz a la misma hora.

**Casa de Mar**:

> Cuatro unidades de 53 m², las más amplias del complejo. Están en primer piso y se desarrollan en dos plantas: abajo cocina, comedor y hogar bajo doble altura; arriba, por escalera de madera, un entrepiso con camas que mira sobre todo el ambiente. Deck propio con vista al parque.

**Chips (`cab-spec`)**: se sumó `✦ 4 unidades` a las tres. En Refugio, `🏠 38 m²` → `🏠 38 m² monoambiente`. En Cabaña, `📺 2 TV` → `🚪 Dormitorio separado` (el diferencial pesa más que los televisores). En Casa se sumó `🪜 2 plantas` y se sacó `☀️ Deck amplio`, que ya está en el texto.

### Verificaciones

- **JSON-LD: no tocado.** `git diff` sobre `application/ld+json` y `aggregateRating` → 0 líneas. Sigue sin `aggregateRating`.
- **Anti-CLS**: las 16 imágenes llevan `width`/`height` reales, medidos leyendo la cabecera del WebP generado (no copiados del JPEG). La única `<img>` sin dimensiones es `#lbImg`, el lienzo del lightbox, que ya era así y no produce CLS.
- **`loading="lazy"` en las 16.** El hero (`IMG_0399`, con `fetchpriority="high"`) no se tocó.
- **Referencias**: las 16 rutas `fotos/webp/*.webp` existen en disco.
- **`#galeria`**: sin cambios. El bento de 5 ítems con `nth-child` sigue igual.
- **Paleta y tipografía**: sin cambios. Cormorant Garamond y las variables CSS intactas.

### Suelto, para decidir después

`IMG_0394`, `IMG_0390` e `IMG_0386` ya no se referencian desde `index.html` (eran las tres imágenes de card). Siguen en `fotos/` y `fotos/webp/` porque no verifiqué si algo más los usa. No los borré. Ver si conviene limpiarlos en un commit aparte.

## Diff completo de `index.html`

```diff
diff --git a/index.html b/index.html
index 2fa8ca8..f08f813 100644
--- a/index.html
+++ b/index.html
@@ -208,6 +208,10 @@ nav.solid .nav-toggle span { background: var(--az2); }
 .cab-img { height: 320px; overflow: hidden; position: relative; }
 .cab-img img { filter: saturate(0.97); transition: transform 0.6s, filter 0.6s; }
 .cab-card:hover .cab-img img { transform: scale(1.04); filter: brightness(1) saturate(1); }
+.cab-thumbs { display: grid; grid-auto-flow: column; grid-auto-columns: 1fr; gap: 4px; margin-top: 4px; }
+.cab-thumb { height: 76px; overflow: hidden; cursor: zoom-in; }
+.cab-thumb img { filter: saturate(0.95); transition: transform 0.5s, filter 0.5s; }
+.cab-thumb:hover img { transform: scale(1.07); filter: brightness(1.03) saturate(1); }
 .cab-tag { position: absolute; top: 16px; left: 16px; background: #fff; color: var(--az); font-size: 9px; font-weight: 500; letter-spacing: 2px; text-transform: uppercase; padding: 5px 12px; }
 .cab-body { padding: 28px 28px 32px; flex: 1; display: flex; flex-direction: column; }
 .cab-name { font-family: 'Cormorant Garamond', serif; font-size: 24px; font-weight: 300; color: var(--t); margin-bottom: 8px; }
@@ -358,6 +362,7 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
   .num-item{flex:1 1 50%;border-right:none;border-bottom:1px solid var(--sep);}
   .cabanas,.reviews-sec,.galeria{padding:64px 20px;}
   .cab-grid{grid-template-columns:1fr;}
+  .cab-thumb{height:92px;}
   .experiencia{grid-template-columns:1fr;}
   .exp-img{height:280px;}
   .exp-text{padding:48px 24px;}
@@ -449,20 +454,24 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
 
     <article class="cab-card r">
       <div class="cab-img">
-        <picture>
-          <source type="image/webp" srcset="fotos/webp/IMG_0394.webp">
-          <img src="fotos/IMG_0394.jpg" alt="Cabaña Refugio de Mar para 2 a 3 personas en Mar de las Pampas" width="1179" height="1463" loading="lazy" decoding="async">
-        </picture>
+        <img src="fotos/webp/refugio-01.webp" alt="Interior del Refugio de Mar en Mar de las Pampas: monoambiente con techo a dos aguas y hogar a leños" width="1126" height="2000" loading="lazy" decoding="async">
         <span class="cab-tag">2 – 3 personas</span>
       </div>
+      <div class="cab-thumbs">
+        <div class="cab-thumb"><img src="fotos/webp/refugio-02.webp" alt="Refugio de Mar en Mar de las Pampas: monoambiente con mesa, estantería divisoria y cama" width="960" height="1280" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/refugio-03.webp" alt="Deck de acceso al Refugio de Mar en Mar de las Pampas, con pérgola y muro de piedra" width="960" height="1280" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/refugio-04.webp" alt="Cocina del Refugio de Mar en Mar de las Pampas bajo el techo a dos aguas" width="1126" height="2000" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/refugio-05.webp" alt="Zona de descanso del Refugio de Mar en Mar de las Pampas con ventana al bosque" width="960" height="1280" loading="lazy" decoding="async"></div>
+      </div>
       <div class="cab-body">
         <h3 class="cab-name">Refugio de Mar</h3>
-        <p class="cab-desc">38 m² de confort total. Cocina equipada, hogar a leños, baño con bañera y deck privado con parrilla. Para una pareja que quiere estar en su mundo.</p>
+        <p class="cab-desc">Son cuatro cabañas iguales, de 38 m² en planta baja. Funcionan como monoambiente: cocina, living y camas comparten un mismo espacio que se abre hacia arriba, con el techo a dos aguas a la vista y la luz cayendo desde la cumbrera. Hogar a leños, baño con bañera y deck propio con parrilla.</p>
         <div class="cab-specs">
-          <span class="cab-spec">🏠 38 m²</span>
+          <span class="cab-spec">🏠 38 m² monoambiente</span>
           <span class="cab-spec">👥 2-3 personas</span>
           <span class="cab-spec">🔥 Hogar a leños</span>
           <span class="cab-spec">🍖 Parrilla propia</span>
+          <span class="cab-spec">✦ 4 unidades</span>
         </div>
         <p class="cab-price">Precio: <strong>consultá por WhatsApp</strong></p>
         <a href="https://api.whatsapp.com/send?phone=5492235365385&text=Hola!%20Me%20interesa%20el%20Refugio%20de%20Mar%20de%20Puerto%20Delf%C3%ADn.%20%C2%BFTienen%20disponibilidad%20y%20cu%C3%A1l%20es%20el%20precio?" class="cab-cta" target="_blank" rel="noopener">
@@ -474,20 +483,24 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
 
     <article class="cab-card r d1">
       <div class="cab-img">
-        <picture>
-          <source type="image/webp" srcset="fotos/webp/IMG_0390.webp">
-          <img src="fotos/IMG_0390.jpg" alt="Cabaña de Mar para hasta 4 personas, pet friendly, en Mar de las Pampas" width="1179" height="1468" loading="lazy" decoding="async">
-        </picture>
+        <img src="fotos/webp/cabana-01.webp" alt="Living comedor de la Cabaña de Mar en Mar de las Pampas con luz natural" width="1200" height="1600" loading="lazy" decoding="async">
         <span class="cab-tag">Hasta 4 personas</span>
       </div>
+      <div class="cab-thumbs">
+        <div class="cab-thumb"><img src="fotos/webp/cabana-02.webp" alt="Dormitorio separado de la Cabaña de Mar en Mar de las Pampas" width="960" height="1280" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/cabana-03.webp" alt="Frente de la Cabaña de Mar en Mar de las Pampas con chimenea de piedra" width="960" height="1280" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/cabana-04.webp" alt="Estar con hogar a leños de la Cabaña de Mar en Mar de las Pampas" width="960" height="1280" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/cabana-05.webp" alt="Pileta del complejo vista desde el deck de la Cabaña de Mar en Mar de las Pampas" width="960" height="1280" loading="lazy" decoding="async"></div>
+      </div>
       <div class="cab-body">
         <h3 class="cab-name">Cabaña de Mar</h3>
-        <p class="cab-desc">38 m² con habitación independiente en planta baja. Dos televisores, calefacción central. La opción ideal para familia o dos parejas con privacidad.</p>
+        <p class="cab-desc">También son cuatro unidades, y miden los mismos 38 m² que el Refugio. Lo que cambia es el plano: acá el dormitorio es un cuarto aparte, con su puerta, separado del living y la cocina. Duermen cuatro sin que todos tengan que apagar la luz a la misma hora.</p>
         <div class="cab-specs">
           <span class="cab-spec">🏠 38 m²</span>
+          <span class="cab-spec">🚪 Dormitorio separado</span>
           <span class="cab-spec">👥 hasta 4</span>
           <span class="cab-spec">🐾 Pet friendly</span>
-          <span class="cab-spec">📺 2 TV</span>
+          <span class="cab-spec">✦ 4 unidades</span>
         </div>
         <p class="cab-price">Precio: <strong>consultá por WhatsApp</strong></p>
         <a href="https://api.whatsapp.com/send?phone=5492235365385&text=Hola!%20Me%20interesa%20la%20Caba%C3%B1a%20de%20Mar%20de%20Puerto%20Delf%C3%ADn.%20%C2%BFTienen%20disponibilidad%20y%20cu%C3%A1l%20es%20el%20precio?" class="cab-cta" target="_blank" rel="noopener">
@@ -499,20 +512,25 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
 
     <article class="cab-card r d2">
       <div class="cab-img">
-        <picture>
-          <source type="image/webp" srcset="fotos/webp/IMG_0386.webp">
-          <img src="fotos/IMG_0386.jpg" alt="Casa de Mar para hasta 6 personas con deck amplio en Mar de las Pampas" width="1179" height="1460" loading="lazy" decoding="async">
-        </picture>
+        <img src="fotos/webp/casa-01.webp" alt="Comedor y entrepiso de la Casa de Mar en Mar de las Pampas, con doble altura" width="900" height="1600" loading="lazy" decoding="async">
         <span class="cab-tag">Hasta 6 personas</span>
       </div>
+      <div class="cab-thumbs">
+        <div class="cab-thumb"><img src="fotos/webp/casa-02.webp" alt="Entrepiso con tres camas de la Casa de Mar en Mar de las Pampas" width="960" height="1280" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/casa-03.webp" alt="Frente en dos plantas de la Casa de Mar en Mar de las Pampas" width="960" height="1280" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/casa-04.webp" alt="Vista desde el entrepiso hacia el comedor de la Casa de Mar en Mar de las Pampas" width="900" height="1600" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/casa-05.webp" alt="Dormitorio de la Casa de Mar en Mar de las Pampas con vigas a la vista" width="900" height="1600" loading="lazy" decoding="async"></div>
+        <div class="cab-thumb"><img src="fotos/webp/casa-06.webp" alt="Parque del complejo visto desde la Casa de Mar en Mar de las Pampas" width="900" height="1600" loading="lazy" decoding="async"></div>
+      </div>
       <div class="cab-body">
         <h3 class="cab-name">Casa de Mar</h3>
-        <p class="cab-desc">53 m² en primer piso con doble altura y luz natural. El espacio más amplio del complejo. Para grupos o familias que quieren lo mejor sin resignar nada.</p>
+        <p class="cab-desc">Cuatro unidades de 53 m², las más amplias del complejo. Están en primer piso y se desarrollan en dos plantas: abajo cocina, comedor y hogar bajo doble altura; arriba, por escalera de madera, un entrepiso con camas que mira sobre todo el ambiente. Deck propio con vista al parque.</p>
         <div class="cab-specs">
           <span class="cab-spec">🏠 53 m²</span>
+          <span class="cab-spec">🪜 2 plantas</span>
           <span class="cab-spec">👥 hasta 6</span>
-          <span class="cab-spec">☀️ Deck amplio</span>
           <span class="cab-spec">🌳 1er piso</span>
+          <span class="cab-spec">✦ 4 unidades</span>
         </div>
         <p class="cab-price">Precio: <strong>consultá por WhatsApp</strong></p>
         <a href="https://api.whatsapp.com/send?phone=5492235365385&text=Hola!%20Me%20interesa%20la%20Casa%20de%20Mar%20de%20Puerto%20Delf%C3%ADn.%20%C2%BFTienen%20disponibilidad%20y%20cu%C3%A1l%20es%20el%20precio?" class="cab-cta" target="_blank" rel="noopener">
@@ -738,7 +756,7 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
 
   // Lightbox de galería
   const lb = document.getElementById('lb'), lbImg = document.getElementById('lbImg');
-  document.querySelectorAll('.gi').forEach(g => {
+  document.querySelectorAll('.gi, .cab-thumb').forEach(g => {
     g.addEventListener('click', () => {
       const img = g.querySelector('img');
       lbImg.src = img.currentSrc || img.src;
```
