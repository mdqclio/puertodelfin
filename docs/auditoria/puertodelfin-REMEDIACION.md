# Remediación — Puerto Delfín

Seguimiento de los hallazgos de [`puertodelfin.md`](./puertodelfin.md).
Fecha: 2026-06-06.

**Leyenda:** ✅ hecho en código · 📄 documentado / preparado (requiere acción del dueño) · ⏳ pendiente (dueño)

Alcance de esta tanda: **solo arreglos seguros y reversibles, en código**. No se desplegó nada, no se reescribió historial, no se rotaron claves.

---

## ✅ Hecho en código

### 1. Reglas de Firebase RTDB versionadas — `database.rules.json` (hallazgo #2 🔴)

Se creó `database.rules.json` con política **deny-by-default** y se wireó la config de Firebase CLI:

- **`database.rules.json`** — `.read`/`.write` en `false` en la raíz y en cada nivel intermedio (`clientes`, `puerto-delfin`, `mensajes`). El acceso se abre **únicamente** en el nodo de conversación `$convId` y solo para **lectura**, condicionado a que el `convId` empiece con `web__` (que es el prefijo que usa el widget: `clientes/puerto-delfin/mensajes/web__<uuid>`).
- **Escritura del cliente: denegada.** El widget no escribe en Firebase (solo hace `POST` al webhook de n8n y **lee** el hilo por `on("value")`). Los mensajes de bot/operador los escribe n8n con el **Admin SDK**, que **bypassa** las Security Rules — por eso poner `.write: false` no rompe el flujo del bot.
- **Validación de forma del mensaje** (`$msgId`): exige exactamente `rol` (string ≤32), `texto` (string ≤8000), `ts` (number), y rechaza cualquier otra clave (`$other: { ".validate": false }`). Esto fija el contrato aunque hoy el cliente no escriba.
- **Wireado de Firebase CLI:** `firebase.json` (apunta `database.rules` → `database.rules.json`) y `.firebaserc` (projectId `botcontrol-base`, detectado en el `FB_CONFIG` del `index.html`).

**Por qué esto es lo más estricto posible sin Firebase Auth:** el sitio es anónimo (no hay login; la "sesión" es un UUID v4 en `localStorage`, 122 bits de entropía). La regla de lectura está **a nivel `$convId`**, no en el padre `mensajes` (que sigue en `false`). En RTDB, conceder `.read` en un hijo **no** permite listar/enumerar los hermanos: para leer un hilo hay que conocer su UUID completo de antemano. Resultado: se bloquea la **enumeración** de conversaciones de otros visitantes y la **escritura** de mensajes falsos desde el cliente, y se aísla `puerto-delfin` del resto de tenants de `clientes/` de la base compartida `botcontrol-base`.

**Reversible:** son archivos nuevos; borrarlos deja todo como estaba. **No se desplegaron** (ver tareas del dueño).

### 2. `.gitignore` (hallazgo #3 🟡)

Se creó `.gitignore` (antes no existía). Cubre `node_modules/`, logs, y sobre todo **secretos de Firebase Admin**: `serviceAccount*.json`, `*-firebase-adminsdk-*.json`, `.env*`, `*.pem`, `*.key`, más artefactos de tooling (`.firebase/`, `*-debug.log`) y cruft de OS/editor. Evita que una credencial de Admin SDK se commitee por accidente al trabajar con `firebase deploy`.

### XSS del widget (hallazgo #6) — ya mitigado, sin cambios

Confirmado escape-first: `escapeHtml` corre **antes** del `linkify`, y los enlaces salen con `rel="noopener noreferrer"`. No requiere acción.

---

## ⏳ Tareas del dueño (fuera de código / requieren credenciales o consola)

### A. Desplegar y verificar las reglas de RTDB — 🔴 (bloqueante)

Las reglas están versionadas pero **NO desplegadas**. Producción sigue con las reglas actuales (desconocidas/posiblemente abiertas) hasta que se publiquen.

Pasos:
1. Revisar `database.rules.json` contra el flujo real (confirmar que n8n escribe con Admin SDK; si escribiera con un token de cliente, habría que ajustar `.write`).
2. **Backup** de las reglas vivas actuales:
   `firebase database:get / --rules-only` o copiarlas desde la consola (Realtime Database → Reglas) antes de pisar.
3. Desplegar **solo** reglas de Database (no tocar Hosting, que es GitHub Pages):
   `firebase deploy --only database --project botcontrol-base`
4. Verificar:
   - El widget de `www.puertodelfin.com` **lee** su hilo (abrir el chat, mandar un mensaje, ver que vuelve la respuesta del bot por Firebase).
   - Un intento de leer el nodo padre `clientes/puerto-delfin/mensajes` da `PERMISSION_DENIED`.
   - Un intento de **escritura** desde un cliente anónimo (consola REST/SDK) a un `web__*` da `PERMISSION_DENIED`.
   - **Regresión cross-tenant:** que los demás clientes de `clientes/` sigan funcionando (estas reglas son para toda la base `botcontrol-base`; el deny-by-default de la raíz puede afectar a otros tenants si dependían de reglas más abiertas — **coordinar** antes de desplegar en la base compartida).

> ⚠️ Importante: `botcontrol-base` es **multi-tenant**. Este `database.rules.json` define reglas para **toda** la base. Si otros tenants tienen sus propias rutas/reglas, hay que **fusionarlas** en este archivo antes de desplegar, o el deploy las dejaría sin acceso. No desplegar a ciegas.

### B. Cerrar el webhook de n8n — auth + rate limiting — 🔴 (hallazgos #4 y #7)

El endpoint `https://automation.alulahostel.com.ar/webhook/puerto-delfin-bot-web` es público, sin token y ligado a un LLM. Fuera de este repo (vive en n8n). Pasos:
1. **Auth:** header secreto (p. ej. `X-PD-Token`) validado en el workflow, o Header Auth nativo del nodo Webhook. (Nota: un token embebido en HTML estático no es secreto real; mejor mover a un proxy/WAF que valide origen + referer + rate limit antes de n8n.)
2. **Validación de payload** en el workflow: forma de `{ idExterno, texto, device }`, longitud máx de `texto`, formato de `idExterno` (debe empezar con `web__`… o el cliente manda el UUID crudo — revisar), rechazar lo que no matchee.
3. **Rate limiting** por IP y por `idExterno` (en n8n, o en el proxy/WAF/Cloudflare delante).
4. Confirmar que el workflow **no** confía el `idExterno` para escribir en hilos ajenos sin validar.

### C. Restringir / rotar la Google Maps API key — 🟡 (hallazgo #3)

La key `AIzaSyD-9...DEv0` quedó en **historial** de Git (ya removida del HTML; hoy el mapa usa embed sin key). **No** se reescribió historial (fuera de alcance). Pasos del dueño en GCP Console:
1. Como sigue en commits viejos, considerarla **comprometida** → **rotarla** (crear nueva, borrar la vieja) en GCP Console → APIs & Services → Credentials.
2. **Restringir** la nueva key: por *Application restriction* = **HTTP referrers** (`https://www.puertodelfin.com/*`, `https://puertodelfin.com/*`) y por *API restriction* = solo Maps Embed/JS API necesaria.
3. Si el sitio ya no usa key de Maps (embed sin key), simplemente **borrar/rotar** la expuesta para que no sea reutilizable con cargo.
4. (Opcional, fuera de alcance acá) limpiar historial con `git filter-repo`/BFG — coordinar porque reescribe historia y requiere force-push.

### D. Monitoreo / uptime / analítica — 🔴 (hallazgo #10)

Hoy las caídas del chat fallan en silencio. Pasos del dueño:
1. **Uptime** del dominio `www.puertodelfin.com` y del webhook de n8n (UptimeRobot/BetterStack/Cron) con alerta.
2. **Analítica** liviana y privacy-friendly (Plausible/Umami/GA4) para medir tráfico y conversión a WhatsApp.
3. (Opcional) error tracking del widget (hoy los errores solo van a `console.error`); como mínimo, una métrica de tasa de fallo del `POST`.

---

## Resumen

| Ítem | Hallazgo | Estado |
|------|----------|--------|
| `database.rules.json` deny-by-default + validación de forma | #2 🔴 | ✅ en código (sin desplegar) |
| `firebase.json` + `.firebaserc` (projectId `botcontrol-base`) | #2 | ✅ |
| `.gitignore` (incl. secretos Admin SDK) | #3 🟡 | ✅ |
| XSS widget | #6 | ✅ ya mitigado |
| Desplegar + verificar reglas RTDB (multi-tenant) | #2 🔴 | ⏳ dueño |
| Auth + rate limit del webhook n8n | #4/#7 🔴 | ⏳ dueño |
| Restringir/rotar Google Maps key | #3 🟡 | ⏳ dueño |
| Monitoreo / uptime / analítica | #10 🔴 | ⏳ dueño |
