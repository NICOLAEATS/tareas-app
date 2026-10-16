# Gestor de Tareas — React + Node.js (Guía 8) — DESPLEGADO

- Repo: https://github.com/NICOLAEATS/tareas-app (`main`)
- API Render: https://tareas-api-pndy.onrender.com/api/tareas (200 OK, CORS restringido)
- Frontend Vercel: https://tareas-app-parkeo-pe.vercel.app (200 OK, título Mis Tareas)
- Dashboard Render: https://dashboard.render.com/web/srv-db8rb86i0phs738odsrg

App full-stack: frontend React (Vite) + backend Node.js + Express, comunicados por API REST + JSON.

## 1. Correr en local (dos terminales)

Terminal 1 — backend:
```
cd server
npm install
npm run dev
# API en http://localhost:3001/api/tareas
```

Terminal 2 — frontend:
```
cd client
npm install
npm run dev
# App en http://localhost:5173
```

Prueba rápida sin navegador:
```
curl http://localhost:3001/api/tareas
curl -X POST http://localhost:3001/api/tareas -H "Content-Type: application/json" -d "{\"titulo\":\"Mi tarea\"}"
curl -X PUT http://localhost:3001/api/tareas/1 -H "Content-Type: application/json" -d "{\"completada\":true}"
curl -X DELETE http://localhost:3001/api/tareas/2
```

Verificado: GET/POST/PUT/DELETE OK, `npm run build` genera `client/dist/` OK.

## 2. Endpoints

| Método | Ruta | Respuesta |
|---|---|---|
| GET | /api/tareas | 200 + JSON array |
| POST | /api/tareas `{"titulo"}` | 201 + tarea creada, 400 si falta título |
| PUT | /api/tareas/:id `{"completada":bool}` | 200 + tarea, 404 si no existe |
| DELETE | /api/tareas/:id | 204, 404 si no existe |

## 3. Archivos cambiados para producción (ya aplicados)

- `server/index.js`: `process.env.PORT || 3001` + `cors({ origin: process.env.CLIENT_URL || "http://localhost:5173" })`
- `client/src/App.jsx`: `const API = import.meta.env.VITE_API_URL || "http://localhost:3001/api/tareas"`
- `client/.env.example`: plantilla (no subir `.env` real)
- `.gitignore`: `node_modules/`, `dist/`, `.env`, `.env.*`

## 4. Subir a GitHub

```powershell
cd "C:\Users\Nouch\Desktop\uac\plataformas\node.js\GESTOR DE TAREAS"
git init
git add server client .gitignore README.md
git commit -m "feat: gestor tareas React+Node listo para Render+Vercel"
gh repo create tareas-app --public --source=. --push
# repo: github.com/NICOLAEATS/tareas-app
```

## 5. Backend en Render (https://render.com) — HECHO

- Repo: https://github.com/NICOLAEATS/tareas-app rama `main`
- Servicio: `tareas-api` id `srv-db8rb86i0phs738odsrg`
- URL pública: https://tareas-api-pndy.onrender.com/api/tareas — probado 200 OK
- Dashboard: https://dashboard.render.com/web/srv-db8rb86i0phs738odsrg
- Config: Root `server`, Build `npm install`, Start `node index.js`, Free, `CLIENT_URL=*` temporal
- Deploy inicial: commit `07abd50` en progreso, API ya responde JSON

## 6. Frontend en Vercel (https://vercel.com)

1. Login con GitHub → Add New → Project → importa `tareas-app`.
2. Edit Root Directory → `client` (debe detectar Vite).
3. Configura:
   - Build Command: `npm run build`
   - Output Directory: `dist`
   - Env var: `VITE_API_URL = https://tareas-api-pndy.onrender.com/api/tareas` (URL real de Render)
4. Deploy (~1 min): `https://tareas-app.vercel.app`

## 7. Seguridad final (paso 4 de la guía)

En Render → tu servicio → Environment → cambia `CLIENT_URL` a tu URL real de Vercel:
```
CLIENT_URL=https://tareas-app.vercel.app
```
Guarda (Render redeploya solo). Ya no uses `*`.

## 8. Diagnóstico

- `curl` a la API primero: si falla, el problema es backend.
- F12 → Network → filtra `tareas`: método, URL, status, JSON.
- `node -v` debe ser v18+.
- Si `VITE_API_URL` no toma efecto: se lee al compilar → cambia en panel Vercel + redeploy; en local reinicia `npm run dev`.
- Render free duerme tras 15 min sin uso: primera petición tarda ~1 min, es normal.

## 9. Entregable

- Repo con `client/` + `server/` + README.
- URL frontend Vercel + URL API Render `/api/tareas`.
- Capturas en `capturas/`: `01-backend-GET-tareas.png` (JSON real), `02-frontend-app-en-vivo.png` (app con 3 tareas, POST 201 verificado en Network: OPTIONS 204 + POST 201 a `tareas-api-pndy`), `03-backend-GET-tareas.json`.
- Pendiente manual: ninguno. Paneles `04-panel-render.png` (tareas-api Live) y `05-panel-vercel.png` (Production Ready) capturados autenticados.
- Sin `.env` ni credenciales en ningún commit.

Criterio guía (20 pts): API en Render 6, frontend en Vercel consumiendo API prod 6, Git + env 4, README con URLs y capturas 4.
