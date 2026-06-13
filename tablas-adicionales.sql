-- ========================================
-- Tablas adicionales para Iglesia Aposento Alto
-- Ejecutar en: Supabase Dashboard → SQL Editor
-- ========================================

-- Tabla de mensajes de contacto (para el panel de administración)
CREATE TABLE IF NOT EXISTS mensajes_contacto (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  iglesia_id UUID NOT NULL REFERENCES iglesias(id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  email TEXT,
  telefono TEXT,
  mensaje TEXT NOT NULL,
  leido BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla de miembros
CREATE TABLE IF NOT EXISTS miembros (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  iglesia_id UUID NOT NULL REFERENCES iglesias(id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  apellido TEXT,
  email TEXT,
  telefono TEXT,
  direccion TEXT,
  fecha_nacimiento DATE,
  ministerio TEXT,
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Tabla de usuarios (opcional, para login personalizado)
CREATE TABLE IF NOT EXISTS usuarios (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  iglesia_id UUID NOT NULL REFERENCES iglesias(id) ON DELETE CASCADE,
  nombre TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  rol TEXT DEFAULT 'admin',
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Activar RLS (Row Level Security) en las nuevas tablas
ALTER TABLE mensajes_contacto ENABLE ROW LEVEL SECURITY;
ALTER TABLE miembros ENABLE ROW LEVEL SECURITY;
ALTER TABLE usuarios ENABLE ROW LEVEL SECURITY;

-- Políticas RLS: permitir acceso con anon key
CREATE POLICY "Acceso publico mensajes" ON mensajes_contacto FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso publico miembros" ON miembros FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Acceso publico usuarios" ON usuarios FOR ALL USING (true) WITH CHECK (true);