# Fix nav desktop + lightbox — diagnóstico headless

Fecha: 2026-09-09 · Verificado con Chromium headless real (Playwright), no análisis estático.

## Entorno de test

No había Chromium, Playwright ni Puppeteer en la máquina, y `agent-browser` tampoco estaba instalado. Instalé Playwright + Chromium en el scratchpad de la sesión (fuera del repo). El binario no arrancaba por 9 librerías de sistema faltantes (`libnspr4.so`, `libnss3.so`, `libatk-1.0.so.0`, `libatspi.so.0`, `libasound.so.2`, `libXdamage.so.1`, `libXRes.so.1`, …) y no hay sudo. Las resolví sin root: `apt-get download` de los `.deb` + `dpkg -x` a un prefijo local y `LD_LIBRARY_PATH`. **Nada de esto tocó el sistema ni el repo.**

Página servida con `python3 -m http.server` en `127.0.0.1:8765`. Viewport desktop 1440×900; el test de swipe usa un contexto móvil 390×844 con `hasTouch`.

---

## BUG 1 — El nav no navegaba en desktop

### Diagnóstico: no era `#pd-chat`

La sospecha del chat quedó descartada por medición directa:

```
#pd-chat  rect[x,y,w,h] = [1360, 84, 60, 60]  z-index = 99999  position = fixed
nav       rect[x,y,w,h] = [0, 0, 1440, 73]    z-index = 100
```

El widget mide 60×60 y arranca en y=84, **por debajo** del nav, que termina en y=73. No hay solape. Su z-index de 99999 es alto pero irrelevante: no comparte área con los links.

### La causa real

`document.elementFromPoint` en el centro de cada link devolvía siempre lo mismo:

```
#cabanas    ( 900, 39)  arriba: nav.foot-links   <<< TAPADO
#galeria    ( 997, 39)  arriba: nav.foot-links   <<< TAPADO
#opiniones  (1098, 39)  arriba: nav.foot-links   <<< TAPADO
#ubicacion  (1208, 39)  arriba: nav.foot-links   <<< TAPADO
```

Y el click real confirmaba el síntoma, con Playwright dando timeout porque el elemento nunca llegaba a ser clickeable:

```
#cabanas    scrollY 0 -> 0  NO NAVEGA  err: page.click: Timeout 2500ms exceeded.
#galeria    scrollY 0 -> 0  NO NAVEGA  err: page.click: Timeout 2500ms exceeded.
#opiniones  scrollY 0 -> 0  NO NAVEGA  err: page.click: Timeout 2500ms exceeded.
#ubicacion  scrollY 0 -> 0  NO NAVEGA  err: page.click: Timeout 2500ms exceeded.
```

El culpable es **`<nav class="foot-links">`, el nav del footer**. El stack completo en (900,39) lo muestra tapando al header:

```
0. nav.foot-links            pos=fixed z=100
1. a                         pos=static
2. li
3. ul#navLinks.nav-links
4. nav#nav                   pos=fixed z=100
```

¿Por qué el nav del footer está fijo arriba de todo? Porque la regla del header estaba escrita como **selector de elemento**:

```css
nav { position: fixed; top: 0; left: 0; right: 0; z-index: 100; … }
```

Eso aplica a *todos* los `<nav>` del documento. El footer tiene `<nav class="foot-links">` (línea 696), cuyo CSS propio es solo `display:flex; gap:24px` — pero heredaba `position:fixed; top:0; z-index:100` de la regla genérica. Con el mismo z-index que el header y estando **después en el DOM**, gana el orden de pintado y queda encima, cubriendo la franja completa de 1440×54 px donde viven los links.

Es un bug latente desde que existe el footer; se hizo visible sin que nadie tocara el nav.

### El fix

Acotar los 6 selectores genéricos al header, que ya tenía `id="nav"`:

```css
nav        { … }   →   #nav        { … }
nav.solid  { … }   →   #nav.solid  { … }
nav.solid .nav-brand      →  #nav.solid .nav-brand
nav.solid .nav-links a    →  #nav.solid .nav-links a
nav.solid .nav-toggle span → #nav.solid .nav-toggle span
@media: nav{…} nav.solid{…} → #nav{…} #nav.solid{…}
```

No toqué `#pd-chat` ni `.wsp-float`: el problema no estaba ahí y moverlos habría sido tapar el síntoma. El `.foot-links` vuelve a ser `position: static` dentro del footer, que es donde tiene que estar.

### Reconfirmación con el mismo test

```
#cabanas    ( 900, 39)  arriba: a           OK
#galeria    ( 997, 39)  arriba: a           OK
#opiniones  (1098, 39)  arriba: a           OK
#ubicacion  (1208, 39)  arriba: a           OK
WhatsApp    (1336, 39)  arriba: a.nav-wsp   OK

#cabanas    scrollY 0 ->  979  NAVEGA
#galeria    scrollY 0 -> 3373  NAVEGA
#opiniones  scrollY 0 -> 4416  NAVEGA
#ubicacion  scrollY 0 -> 5751  NAVEGA
```

---

## BUG 2 — Lightbox

### Cambios

**Disparador.** El selector pasó de `.gi, .cab-thumb` a incluir `.cab-img`, así que la foto principal de cada ficha ahora abre el lightbox. Se le agregó `cursor: zoom-in` para que se note que es clickeable.

**Sets.** Antes no existía el concepto: el lightbox mostraba una imagen suelta. Ahora se arman grupos al cargar la página — uno para la galería (5 fotos) y uno por ficha, con la principal primero y las miniaturas en orden (`refugio-01…05`, `cabana-01…05`, `casa-01…06`). Al abrir desde cualquier imagen, la navegación se mueve **dentro de ese set**, sin saltar a otra ficha.

**Navegación.** Flechas `‹` `›` en pantalla, teclado ←/→, y swipe horizontal en touch (umbral 45 px, y solo si el movimiento horizontal supera al vertical, para no robarle el scroll a un swipe diagonal). El recorrido es circular. Un contador discreto abajo muestra `3 / 6`. Si un set tuviera una sola imagen, flechas y contador se ocultan solos.

**Cierre.** Escape y click en el fondo siguen cerrando, igual que antes. Las flechas hacen `stopPropagation` para no cerrar al navegar. Un swipe marca una bandera que se consume en el click siguiente, porque en touch el gesto también dispara `click` y sin eso cada swipe cerraría el lightbox.

**Escape** ahora está guardado tras un chequeo de que el lightbox esté abierto, en vez de correr en cada tecla del documento.

### Resultados del test (17/17)

```
=== foto principal (-01) de cada ficha abre el lightbox ===
  OK     Refugio: abre con refugio-01.webp  contador "1 / 5"
  OK     Cabaña: abre con cabana-01.webp  contador "1 / 5"
  OK     Casa: abre con casa-01.webp  contador "1 / 6"
=== navegación con teclado dentro del set (ficha Casa, 6 fotos) ===
  OK     inicio: casa-01.webp (1 / 6)
  OK     2x derecha: casa-03.webp (3 / 6)
  OK     1x izquierda: casa-02.webp (2 / 6)
=== wrap-around circular ===
  OK     desde la 1 hacia atrás: casa-06.webp (6 / 6)
=== flechas en pantalla (click no cierra) ===
  OK     lbNext: casa-01.webp, sigue abierto=true
  OK     lbPrev: casa-06.webp, sigue abierto=true
=== Escape y click en fondo cierran ===
  OK     Escape cierra
  OK     click en el fondo cierra
=== set de la galería sigue siendo independiente ===
  OK     galería: IMG_0395.webp (2 / 5)
=== miniaturas: entran en el set en su posición ===
  OK     3ra miniatura de Refugio: refugio-04.webp (4 / 5)
=== swipe touch ===
  OK     tap abre: casa-01.webp (1 / 6)
  OK     swipe izquierda: casa-02.webp (2 / 6), abierto=true
  OK     swipe derecha: casa-01.webp (1 / 6), abierto=true
=== boton flotante de WhatsApp intacto ===
  OK     wsp-float rect=[1252,828,164,48] arriba=a.wsp-float.show
  info   #pd-chat rect=[1360,84,60,60] (sin tocar)
```

### Dos fallas del test que no eran del código

Vale dejarlas anotadas para no repetirlas:

1. El chequeo de "click en el fondo cierra" usaba el punto (30, 450), que cae **exactamente sobre la flecha anterior** (`left:18px`, 52×72 centrada verticalmente → ocupa x 18-70, y 414-486). El lightbox no se cerraba porque estaba navegando, que es el comportamiento correcto. Moví el punto a (720, 60).
2. El swipe sintético fallaba con `TypeError: Failed to construct 'TouchEvent'`: Chromium exige objetos `Touch` reales, no literales. Se corrigió usando `new Touch({ identifier, target, clientX, clientY })`.

---

## Verificaciones finales

- **Botón flotante de WhatsApp:** `rect=[1252,828,164,48]`, y `elementFromPoint` en su centro devuelve `a.wsp-float.show`. Clickeable, nada encima. No se movió.
- **`#pd-chat`:** sin tocar, sigue en `[1360,84,60,60]` con z-index 99999.
- **JSON-LD:** sin cambios, sigue sin `aggregateRating`.
- **Fotos y copy** del commit anterior: sin cambios.
- **Total:** 62 inserciones, 18 borrados, solo `index.html`.

## Diff completo

```diff
diff --git a/index.html b/index.html
index f08f813..4944bf8 100644
--- a/index.html
+++ b/index.html
@@ -136,24 +136,24 @@ img { display: block; width: 100%; height: 100%; object-fit: cover; }
 .wsp-float .icon { width: 20px; height: 20px; }
 
 /* NAV */
-nav {
+#nav {
   position: fixed; top: 0; left: 0; right: 0; z-index: 100;
   padding: 22px 48px; display: flex; justify-content: space-between; align-items: center;
   transition: all 0.4s;
 }
-nav.solid { background: rgba(253,251,248,0.97); padding: 14px 48px; border-bottom: 1px solid var(--sep); backdrop-filter: blur(10px); }
+#nav.solid { background: rgba(253,251,248,0.97); padding: 14px 48px; border-bottom: 1px solid var(--sep); backdrop-filter: blur(10px); }
 .nav-brand { font-family: 'Cormorant Garamond', serif; font-size: 18px; font-weight: 400; color: #fff; letter-spacing: 1.5px; text-decoration: none; transition: color 0.4s; }
 .nav-brand small { display: block; font-family: 'Inter', sans-serif; font-size: 9px; letter-spacing: 3px; text-transform: uppercase; opacity: 0.6; margin-top: 2px; font-weight: 300; }
-nav.solid .nav-brand { color: var(--az2); }
+#nav.solid .nav-brand { color: var(--az2); }
 .nav-links { display: flex; gap: 32px; list-style: none; align-items: center; }
 .nav-links a { color: rgba(255,255,255,0.78); text-decoration: none; font-size: 11px; letter-spacing: 2px; text-transform: uppercase; font-weight: 400; transition: color 0.2s; }
-nav.solid .nav-links a { color: var(--ts); }
+#nav.solid .nav-links a { color: var(--ts); }
 .nav-links a:hover { color: var(--az) !important; }
 .nav-wsp { background: var(--wsp) !important; color: #fff !important; padding: 9px 20px; border-radius: 2px; font-weight: 500 !important; }
 .nav-wsp:hover { background: var(--wsp2) !important; }
 .nav-toggle { display: none; background: none; border: none; cursor: pointer; width: 30px; height: 24px; padding: 0; z-index: 101; }
 .nav-toggle span { display: block; height: 2px; width: 100%; background: #fff; margin: 6px 0; border-radius: 2px; transition: all 0.3s; }
-nav.solid .nav-toggle span { background: var(--az2); }
+#nav.solid .nav-toggle span { background: var(--az2); }
 
 /* HERO */
 .hero { height: 100vh; min-height: 660px; position: relative; display: flex; align-items: flex-end; overflow: hidden; }
@@ -205,7 +205,7 @@ nav.solid .nav-toggle span { background: var(--az2); }
 .cab-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; max-width: 1180px; margin: 0 auto; }
 .cab-card { background: var(--b); border: 1px solid var(--sep); display: flex; flex-direction: column; transition: box-shadow 0.35s, transform 0.35s; }
 .cab-card:hover { box-shadow: 0 22px 56px rgba(91,126,153,0.18); transform: translateY(-4px); z-index: 2; position: relative; }
-.cab-img { height: 320px; overflow: hidden; position: relative; }
+.cab-img { height: 320px; overflow: hidden; position: relative; cursor: zoom-in; }
 .cab-img img { filter: saturate(0.97); transition: transform 0.6s, filter 0.6s; }
 .cab-card:hover .cab-img img { transform: scale(1.04); filter: brightness(1) saturate(1); }
 .cab-thumbs { display: grid; grid-auto-flow: column; grid-auto-columns: 1fr; gap: 4px; margin-top: 4px; }
@@ -338,6 +338,10 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
 .lb img { width: auto; height: auto; max-width: 95%; max-height: 90%; object-fit: contain; border-radius: 2px; box-shadow: 0 20px 60px rgba(0,0,0,0.5); }
 .lb-close { position: absolute; top: 18px; right: 28px; color: #fff; font-size: 42px; line-height: 1; cursor: pointer; opacity: 0.8; }
 .lb-close:hover { opacity: 1; }
+.lb-nav { position: absolute; top: 50%; transform: translateY(-50%); width: 52px; height: 72px; border: none; background: rgba(255,255,255,0.10); color: #fff; font-size: 34px; line-height: 1; cursor: pointer; opacity: 0.75; transition: opacity 0.2s, background 0.2s; }
+.lb-nav:hover { opacity: 1; background: rgba(255,255,255,0.20); }
+.lb-prev { left: 18px; } .lb-next { right: 18px; }
+.lb-count { position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%); color: rgba(255,255,255,0.65); font-size: 11px; letter-spacing: 2px; }
 
 /* REVEAL */
 .r { opacity: 0; transform: translateY(22px); transition: opacity 0.85s ease, transform 0.85s ease; }
@@ -346,7 +350,7 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
 
 /* MOBILE */
 @media(max-width:900px){
-  nav{padding:16px 20px;} nav.solid{padding:12px 20px;}
+  #nav{padding:16px 20px;} #nav.solid{padding:12px 20px;}
   .nav-toggle{display:block;}
   .nav-links{
     position:fixed; top:0; right:0; height:100vh; width:78%; max-width:320px;
@@ -377,6 +381,7 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
   footer{flex-direction:column;text-align:center;padding:32px 20px;}
   .foot-links{flex-wrap:wrap;justify-content:center;}
   .wsp-float{bottom:16px;right:16px;}
+  .lb-nav{width:44px;height:60px;font-size:28px;} .lb-prev{left:6px;} .lb-next{right:6px;}
 }
 </style>
 </head>
@@ -706,7 +711,10 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
 <!-- LIGHTBOX -->
 <div class="lb" id="lb" role="dialog" aria-modal="true" aria-label="Imagen ampliada">
   <span class="lb-close" id="lbClose" aria-label="Cerrar">&times;</span>
+  <button class="lb-nav lb-prev" id="lbPrev" type="button" aria-label="Imagen anterior">&#8249;</button>
   <img id="lbImg" src="" alt="">
+  <button class="lb-nav lb-next" id="lbNext" type="button" aria-label="Imagen siguiente">&#8250;</button>
+  <span class="lb-count" id="lbCount" aria-hidden="true"></span>
 </div>
 
 <script>
@@ -754,19 +762,55 @@ footer { background: var(--t); padding: 40px 56px; display: flex; justify-conten
   }, { threshold: 0, rootMargin: '0px 0px -55px 0px' });
   document.querySelectorAll('.r').forEach(el => obs.observe(el));
 
-  // Lightbox de galería
+  // Lightbox: galería + fichas, con navegación dentro del set abierto
   const lb = document.getElementById('lb'), lbImg = document.getElementById('lbImg');
-  document.querySelectorAll('.gi, .cab-thumb').forEach(g => {
-    g.addEventListener('click', () => {
-      const img = g.querySelector('img');
-      lbImg.src = img.currentSrc || img.src;
-      lbImg.alt = img.alt;
-      lb.classList.add('open');
-    });
+  const lbPrev = document.getElementById('lbPrev'), lbNext = document.getElementById('lbNext');
+  const lbCount = document.getElementById('lbCount');
+
+  // Un set por galería y uno por ficha (principal + miniaturas, en orden)
+  const groups = [];
+  const addGroup = imgs => { if (imgs.length) groups.push(imgs); };
+  addGroup([...document.querySelectorAll('.gal-grid .gi img')]);
+  document.querySelectorAll('.cab-card').forEach(card =>
+    addGroup([...card.querySelectorAll('.cab-img img, .cab-thumb img')]));
+
+  let group = null, idx = 0;
+  const show = i => {
+    if (!group) return;
+    idx = (i + group.length) % group.length;
+    const im = group[idx];
+    lbImg.src = im.currentSrc || im.src;
+    lbImg.alt = im.alt;
+    const solo = group.length < 2;
+    lbPrev.hidden = lbNext.hidden = solo;
+    lbCount.textContent = solo ? '' : (idx + 1) + ' / ' + group.length;
+  };
+  groups.forEach(g => g.forEach((im, i) => {
+    const trigger = im.closest('.gi, .cab-img, .cab-thumb');
+    if (trigger) trigger.addEventListener('click', () => { group = g; show(i); lb.classList.add('open'); });
+  }));
+
+  const closeLb = () => { lb.classList.remove('open'); group = null; };
+  const step = n => e => { e.stopPropagation(); show(idx + n); };
+  lbPrev.addEventListener('click', step(-1));
+  lbNext.addEventListener('click', step(1));
+
+  let swiped = false;
+  lb.addEventListener('click', () => { if (swiped) { swiped = false; return; } closeLb(); });
+  document.addEventListener('keydown', e => {
+    if (!lb.classList.contains('open')) return;
+    if (e.key === 'Escape') closeLb();
+    else if (e.key === 'ArrowLeft') show(idx - 1);
+    else if (e.key === 'ArrowRight') show(idx + 1);
   });
-  const closeLb = () => lb.classList.remove('open');
-  lb.addEventListener('click', closeLb);
-  document.addEventListener('keydown', e => { if (e.key === 'Escape') closeLb(); });
+  let tx = 0, ty = 0;
+  lb.addEventListener('touchstart', e => {
+    tx = e.changedTouches[0].clientX; ty = e.changedTouches[0].clientY;
+  }, { passive: true });
+  lb.addEventListener('touchend', e => {
+    const dx = e.changedTouches[0].clientX - tx, dy = e.changedTouches[0].clientY - ty;
+    if (Math.abs(dx) > 45 && Math.abs(dx) > Math.abs(dy)) { swiped = true; show(idx + (dx < 0 ? 1 : -1)); }
+  }, { passive: true });
 </script>
 
 <!-- ===== Puerto Delfín chat widget ===== -->
```
