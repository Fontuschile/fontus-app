-- =====================================================
-- FONTUS — Schema base de datos Supabase
-- Versión corregida: usa IF NOT EXISTS para evitar errores
-- =====================================================

create extension if not exists "uuid-ossp";

-- CLIENTES
create table if not exists clientes (
  id bigserial primary key,
  nombre text not null,
  rut text default '',
  tipo text default 'venta',
  direccion text default '',
  comuna text default '',
  region text default 'RM',
  telefono text default '',
  mail text default '',
  fecha_instalacion date,
  fecha_sig_mant date,
  dias_desde_mant integer default 0,
  modelo text default '500 gpd',
  vendedor text default '',
  empresa text default 'fontus',
  segmento text default 'residencial',
  monto_arriendo integer default 0,
  meses_mora integer default 0,
  filtros_pc integer default 0,
  filtros_ro integer default 0,
  filtros_c2 integer default 0,
  total_mantenciones integer default 0,
  observacion text default '',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- MANTENCIONES
create table if not exists mantenciones (
  id bigserial primary key,
  cliente_id bigint references clientes(id) on delete cascade,
  fecha date not null,
  tecnico text default '',
  filtros_pc integer default 0,
  filtros_ro integer default 0,
  filtros_c2 integer default 0,
  cobro text default 'gratis',
  costo_traslado integer default 0,
  costo_tecnico integer default 0,
  observacion text default '',
  evaluacion text default '',
  created_at timestamptz default now()
);

-- FOTOS
create table if not exists fotos (
  id bigserial primary key,
  cliente_id bigint references clientes(id) on delete cascade,
  mantencion_id bigint references mantenciones(id) on delete cascade,
  tipo text default 'instalacion',
  etiqueta text default '',
  url text not null,
  created_at timestamptz default now()
);

-- PAGOS
create table if not exists pagos (
  id bigserial primary key,
  cliente_id bigint references clientes(id) on delete cascade,
  mes text not null,
  monto integer not null,
  fecha_pago date,
  origen text default 'manual',
  estado text default 'pagado',
  created_at timestamptz default now()
);

-- MAQUINAS
create table if not exists maquinas (
  id bigserial primary key,
  modelo text not null,
  color text default 'Blanco',
  variante text default 'Estándar',
  numero_serie text default '',
  condicion text default 'nueva',
  notas text default '',
  created_at timestamptz default now()
);

-- INSUMOS
create table if not exists insumos (
  id bigserial primary key,
  nombre text not null,
  categoria text default 'Accesorio',
  unidad text default 'unid',
  stock integer default 0,
  stock_min integer default 2,
  precio_costo integer default 0,
  notas text default '',
  created_at timestamptz default now()
);

-- PLANES
create table if not exists planes (
  id bigserial primary key,
  cliente_id bigint references clientes(id) on delete cascade,
  tipo text default 'basico',
  precio integer default 25000,
  fecha_inicio date,
  fecha_fin date,
  estado text default 'activo',
  notas text default '',
  created_at timestamptz default now()
);

-- CONTACTOS
create table if not exists contactos (
  id bigserial primary key,
  cliente_id bigint references clientes(id) on delete cascade,
  fecha date not null,
  tipo text default 'whatsapp',
  resultado text default '',
  nota text default '',
  usuario text default '',
  created_at timestamptz default now()
);

-- AGENDA
create table if not exists agenda (
  id bigserial primary key,
  cliente_id bigint references clientes(id) on delete cascade,
  fecha date not null,
  tecnico text default '',
  motivo text default 'Mantención',
  notas text default '',
  estado text default 'pendiente',
  created_at timestamptz default now()
);

-- CHANGELOG
create table if not exists changelog (
  id bigserial primary key,
  cliente_id bigint references clientes(id) on delete cascade,
  fecha date not null,
  campo text,
  valor_antes text,
  valor_despues text,
  created_at timestamptz default now()
);

-- RLS
alter table clientes enable row level security;
alter table mantenciones enable row level security;
alter table fotos enable row level security;
alter table pagos enable row level security;
alter table maquinas enable row level security;
alter table insumos enable row level security;
alter table planes enable row level security;
alter table contactos enable row level security;
alter table agenda enable row level security;
alter table changelog enable row level security;

-- Eliminar políticas si existen antes de crearlas
drop policy if exists "Authenticated users only" on clientes;
drop policy if exists "Authenticated users only" on mantenciones;
drop policy if exists "Authenticated users only" on fotos;
drop policy if exists "Authenticated users only" on pagos;
drop policy if exists "Authenticated users only" on maquinas;
drop policy if exists "Authenticated users only" on insumos;
drop policy if exists "Authenticated users only" on planes;
drop policy if exists "Authenticated users only" on contactos;
drop policy if exists "Authenticated users only" on agenda;
drop policy if exists "Authenticated users only" on changelog;

-- Crear políticas
create policy "Authenticated users only" on clientes for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on mantenciones for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on fotos for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on pagos for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on maquinas for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on insumos for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on planes for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on contactos for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on agenda for all using (auth.role() = 'authenticated');
create policy "Authenticated users only" on changelog for all using (auth.role() = 'authenticated');

-- Storage bucket para fotos (solo si no existe)
insert into storage.buckets (id, name, public)
values ('fontus-fotos', 'fontus-fotos', true)
on conflict (id) do nothing;

drop policy if exists "Authenticated upload" on storage.objects;
drop policy if exists "Public read" on storage.objects;
drop policy if exists "Authenticated delete" on storage.objects;

create policy "Authenticated upload" on storage.objects for insert with check (auth.role() = 'authenticated' and bucket_id = 'fontus-fotos');
create policy "Public read" on storage.objects for select using (bucket_id = 'fontus-fotos');
create policy "Authenticated delete" on storage.objects for delete using (auth.role() = 'authenticated' and bucket_id = 'fontus-fotos');
