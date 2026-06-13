# FONTUS — App de Gestión Online

## Credenciales del proyecto
- **Supabase URL:** https://cdwegyosuozcffxilueg.supabase.co
- **GitHub:** github.com/Fontuschile/fontus-app
- **App URL:** fontuschile.github.io/fontus-app

## Pasos para dejar funcionando

### 1 — Subir index.html correctamente (con GitHub Desktop)
1. Instalar GitHub Desktop desde desktop.github.com
2. Iniciar sesión con cuenta GitHub
3. Clonar repositorio: Fontuschile/fontus-app
4. Reemplazar index.html en la carpeta clonada
5. Commit "Corregir index.html" → Push origin

### 2 — Ejecutar SQL en Supabase
1. supabase.com → tu proyecto → SQL Editor
2. New query → pegar contenido de schema.sql → Run
3. Debe aparecer verde sin errores

### 3 — Crear usuarios del equipo
1. Supabase → Authentication → Users
2. Add user → Create new user
3. Crear uno por cada miembro: Poli, Felipe, Pato, Diego

### 4 — Conectar dominio app.fontus.cl (Hosting.cl)
1. Login en panel.hosting.cl
2. DNS Zone Editor → Add Record
3. Tipo: CNAME | Nombre: app | Valor: fontuschile.github.io
4. Guardar y esperar 24-48 horas

## Equipo FONTUS
- Poli, Felipe, Pato, Diego
