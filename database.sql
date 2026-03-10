CREATE DATABASE IF NOT EXISTS eps_citas_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE eps_citas_db;

DROP TABLE IF EXISTS citas;
DROP TABLE IF EXISTS pacientes;
DROP TABLE IF EXISTS medicos;

CREATE TABLE pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    documento VARCHAR(20) NOT NULL,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(120) NOT NULL,
    eps VARCHAR(80) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY uq_pacientes_documento (documento)
);

CREATE TABLE medicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    especialidad VARCHAR(80) NOT NULL,
    consultorio VARCHAR(20) NOT NULL,
    activo TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE citas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    tipo_cita VARCHAR(40) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    modalidad VARCHAR(20) NOT NULL,
    sede VARCHAR(120) NOT NULL,
    observaciones VARCHAR(255) NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'PROGRAMADA',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_citas_paciente
        FOREIGN KEY (paciente_id) REFERENCES pacientes(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_citas_medico
        FOREIGN KEY (medico_id) REFERENCES medicos(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_citas_estado
        CHECK (estado IN ('PROGRAMADA', 'ATENDIDA', 'CANCELADA')),
    CONSTRAINT chk_citas_modalidad
        CHECK (modalidad IN ('PRESENCIAL', 'VIRTUAL')),
    UNIQUE KEY uq_citas_medico_horario (medico_id, fecha, hora),
    KEY idx_citas_paciente_fecha (paciente_id, fecha)
);

INSERT INTO medicos (nombre, especialidad, consultorio, activo) VALUES
('Carlos Ramirez', 'Medicina General', 'A-101', 1),
('Laura Mendoza', 'Odontologia', 'B-204', 1),
('Felipe Rojas', 'Pediatria', 'C-118', 1),
('Natalia Gomez', 'Ginecologia', 'D-305', 1),
('Andrea Suarez', 'Laboratorio Clinico', 'L-009', 1);

INSERT INTO pacientes (documento, nombres, apellidos, fecha_nacimiento, telefono, email, eps) VALUES
('1000234567', 'Juan', 'Perez', '1998-08-19', '3001234567', 'juan.perez@email.com', 'Nueva EPS');
