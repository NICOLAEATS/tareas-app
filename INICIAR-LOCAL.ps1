# Abre backend (server) y frontend (client) en 2 ventanas para trabajo local.
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$node = (node -v) 2>$null
if (-not $node) { Write-Host "ERROR: Node.js no encontrado. Instala Node.js LTS v18+ y reintenta."; pause; exit 1 }
Write-Host "Node $node detectado. Abriendo 2 terminales..."
Start-Process powershell -ArgumentList "-NoExit","-Command","cd '$root\server'; npm install; npm run dev"
Start-Process powershell -ArgumentList "-NoExit","-Command","cd '$root\client'; npm install; npm run dev"
Write-Host "Listo: API http://localhost:3001/api/tareas | App http://localhost:5173"
