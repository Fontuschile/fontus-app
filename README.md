# FONTUS — App de Gestión Online

## Instrucciones de instalación

### Paso 1 — Configurar Supabase
1. Ve a supabase.com y abre tu proyecto
2. En el menú izquierdo clic en "SQL Editor"
3. Copia y pega el contenido de `schema.sql`
4. Clic en "Run"
5. Ve a Project Settings → API
6. Copia "Project URL" y "anon public key"

### Paso 2 — Configurar Vercel
1. Importa este repositorio en Vercel
2. En "Environment Variables" agrega:
   - `SUPABASE_URL` = tu Project URL
   - `SUPABASE_KEY` = tu anon public key
3. Deploy

### Paso 3 — Dominio en Hosting.cl
1. Login en panel.hosting.cl
2. DNS Zone Editor
3. Agregar CNAME: `app` → `cname.vercel-dns.com`
4. En Vercel: Settings → Domains → agregar `app.fontus.cl`

### Paso 4 — Crear usuarios
1. En Supabase → Authentication → Users
2. "Invite user" con el correo de cada miembro del equipo
