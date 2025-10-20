-- ====================================================================
-- SISTEMA DE GESTIÓN DE TERAPIAS Y PACIENTES (POSTGRESQL DDL)
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. TABLA PROFESIONALES (Profesional que registra los datos)
-- --------------------------------------------------------------------
-- Esta tabla mapea el 'userId' de Firebase para trazabilidad.
-- Se asume un sistema de usuarios simple.
CREATE TABLE profesionales (
    profesional_id VARCHAR(50) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    fecha_registro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE profesionales IS 'Profesionales o usuarios del sistema que registran pacientes, sesiones y productos.';


-- --------------------------------------------------------------------
-- 2. TABLA PACIENTES (Datos Personales y Demográficos)
-- --------------------------------------------------------------------
CREATE TABLE pacientes (
    paciente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    sexo VARCHAR(20), -- Masculino, Femenino, Otro
    estado_civil VARCHAR(20), -- Soltero, Casado, Divorciado, Viudo
    ocupacion VARCHAR(100),
    direccion TEXT,
    
    -- Trazabilidad
    registrado_por VARCHAR(50) REFERENCES profesionales(profesional_id) ON DELETE SET NULL,
    fecha_registro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITH TIME ZONE
);

COMMENT ON TABLE pacientes IS 'Datos personales y demográficos principales de los pacientes.';


-- --------------------------------------------------------------------
-- 3. TABLA HISTORIAL_CLINICO (Sección detallada del cuestionario)
-- --------------------------------------------------------------------
-- Esta tabla contiene el Historial Clínico detallado y tiene una
-- relación uno-a-uno (1:1) con la tabla de Pacientes.
CREATE TABLE historial_clinico (
    historial_id SERIAL PRIMARY KEY,
    paciente_id INTEGER UNIQUE REFERENCES pacientes(paciente_id) ON DELETE CASCADE NOT NULL,
    
    -- II. Motivo de la Consulta
    motivo_consulta TEXT NOT NULL,
    tiempo_problema VARCHAR(100),
    
    -- III. Antecedentes Personales (Textos y Específicos)
    otras_enfermedades TEXT,
    medicamentos_actuales TEXT,
    hospitalizaciones TEXT,
    alergias_detalle TEXT,
    
    -- IV. Antecedentes Familiares (Textos)
    otras_familiares TEXT,
    parentesco_familiar VARCHAR(100),
    
    -- V. Hábitos y Estilo de Vida
    cigarrillos_dia INTEGER DEFAULT 0,
    frecuencia_alcohol VARCHAR(100),
    tipo_actividad_fisica VARCHAR(100),
    frecuencia_actividad_fisica VARCHAR(100),
    alimentacion VARCHAR(50), -- Saludable, Regular, Pobre
    horas_dormir NUMERIC(4, 2),
    
    -- VI. Mujeres
    menstruacion_edad INTEGER,
    num_embarazos INTEGER DEFAULT 0,
    metodo_anticonceptivo VARCHAR(100),
    
    -- VII. Observaciones Médicas (Uso del profesional)
    observaciones_medicas TEXT
);

COMMENT ON TABLE historial_clinico IS 'Contiene el historial médico detallado, con relación 1:1 al paciente.';


-- --------------------------------------------------------------------
-- 4. TABLA BOOLEANOS_CLINICOS (Separación de Checkboxes para Normalización)
-- --------------------------------------------------------------------
-- Esta tabla almacena los indicadores booleanos (checkboxes) del historial,
-- evitando tener muchas columnas booleanas en la tabla principal.
CREATE TABLE booleanos_clinicos (
    paciente_id INTEGER PRIMARY KEY REFERENCES pacientes(paciente_id) ON DELETE CASCADE NOT NULL,
    
    -- III. Antecedentes Personales
    enfermedad_diabetes BOOLEAN DEFAULT FALSE,
    enfermedad_hipertension BOOLEAN DEFAULT FALSE,
    enfermedad_cardiaca BOOLEAN DEFAULT FALSE,
    enfermedad_asma BOOLEAN DEFAULT FALSE,
    enfermedad_alergias BOOLEAN DEFAULT FALSE,
    enfermedad_cancer BOOLEAN DEFAULT FALSE,
    enfermedad_epilepsia BOOLEAN DEFAULT FALSE,
    enfermedad_renal BOOLEAN DEFAULT FALSE,
    enfermedad_hepatitis BOOLEAN DEFAULT FALSE,
    transfusiones BOOLEAN DEFAULT FALSE,
    
    -- IV. Antecedentes Familiares
    familiar_diabetes BOOLEAN DEFAULT FALSE,
    familiar_hipertension BOOLEAN DEFAULT FALSE,
    familiar_cancer BOOLEAN DEFAULT FALSE,
    familiar_cardiopatias BOOLEAN DEFAULT FALSE,
    
    -- V. Hábitos y Estilo de Vida
    fuma BOOLEAN DEFAULT FALSE,
    consume_alcohol BOOLEAN DEFAULT FALSE,
    actividad_fisica BOOLEAN DEFAULT FALSE,
    duerme_bien BOOLEAN DEFAULT FALSE,
    
    -- VI. Mujeres
    ciclo_regular BOOLEAN DEFAULT FALSE,
    embarazada_actualmente BOOLEAN DEFAULT FALSE
);

COMMENT ON TABLE booleanos_clinicos IS 'Campos booleanos del historial clínico (respuestas Sí/No o Checkboxes).';


-- --------------------------------------------------------------------
-- 5. TABLA SESIONES (Registro de cada Terapia Aplicada)
-- --------------------------------------------------------------------
CREATE TABLE sesiones (
    sesion_id SERIAL PRIMARY KEY,
    paciente_id INTEGER REFERENCES pacientes(paciente_id) ON DELETE CASCADE NOT NULL,
    
    -- Datos de la Sesión
    fecha_hora_sesion TIMESTAMP WITH TIME ZONE NOT NULL,
    tipo_terapia VARCHAR(100) NOT NULL,
    
    -- Datos Clínicos de la Sesión
    dolor_inicial INTEGER CHECK (dolor_inicial BETWEEN 1 AND 10),
    dolor_final INTEGER CHECK (dolor_final BETWEEN 1 AND 10),
    notas_objetivas TEXT NOT NULL,
    aplicacion TEXT NOT NULL,
    recomendaciones TEXT,
    photo_url VARCHAR(2048), -- Enlace a la imagen de referencia
    
    -- Trazabilidad
    registrado_por VARCHAR(50) REFERENCES profesionales(profesional_id) ON DELETE SET NULL,
    fecha_registro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE sesiones IS 'Registro de cada terapia, masaje o rehabilitación aplicada a un paciente.';


-- --------------------------------------------------------------------
-- 6. TABLA CATALOGO_ELEMENTOS (Productos y Servicios)
-- --------------------------------------------------------------------
-- Utiliza un tipo ENUM para forzar que el tipo sea 'Servicio' o 'Producto'.
CREATE TYPE tipo_elemento AS ENUM ('Servicio', 'Producto');

CREATE TABLE catalogo_elementos (
    elemento_id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    tipo tipo_elemento NOT NULL,
    precio NUMERIC(10, 2) NOT NULL CHECK (precio >= 0),
    descripcion TEXT,
    
    -- Stock solo aplica para 'Producto'. Se asume 0 para 'Servicio'.
    stock INTEGER DEFAULT 0 CHECK (stock >= 0),
    
    -- Trazabilidad
    registrado_por VARCHAR(50) REFERENCES profesionales(profesional_id) ON DELETE SET NULL,
    fecha_registro TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP WITH TIME ZONE
);

COMMENT ON TABLE catalogo_elementos IS 'Catálogo de masajes, terapias, rehabilitaciones (Servicios) y artículos de venta (Productos).';
