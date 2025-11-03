CREATE TABLE roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

INSERT INTO roles (name, description) VALUES
('Administrator', 'Manages system settings and staff'),
('Physician', 'Licensed TCM practitioner'),
('Receptionist', 'Manages appointments');

CREATE TABLE staff (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    role_id INT NOT NULL,
    license_number VARCHAR(20) UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT
);

CREATE TABLE patients (
    nric VARCHAR(9) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE NOT NULL,
    chief_complaint TEXT
);

CREATE TABLE treatment_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    duration_minutes INT NOT NULL CHECK (duration_minutes IN (30, 45, 60, 90))
);

CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type VARCHAR(50) NOT NULL
);

CREATE TABLE appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_nric VARCHAR(9) NOT NULL,
    physician_staff_id INT NOT NULL,
    room_id INT NOT NULL,
    treatment_type_id INT NOT NULL,
    scheduled_datetime DATETIME NOT NULL,
    status ENUM('scheduled', 'completed', 'cancelled') DEFAULT 'scheduled',
    
    FOREIGN KEY (patient_nric) REFERENCES patients(nric) ON DELETE CASCADE,
    FOREIGN KEY (physician_staff_id) REFERENCES staff(id) ON DELETE RESTRICT,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE RESTRICT,
    FOREIGN KEY (treatment_type_id) REFERENCES treatment_types(id) ON DELETE RESTRICT
);

-- Staff
INSERT INTO staff (name, role_id, license_number, username, password) VALUES
('Ng Li Wen', 1, NULL, 'admin.ng', 'admin123'),
('Dr. Lim', 2, 'TCM-SG-2020-001', 'dr.lim', 'pass123'),
('Sarah', 3, NULL, 'reception.sarah', 'desk123');

-- Patients
INSERT INTO patients (nric, name, phone, date_of_birth, chief_complaint) VALUES
('S8512345A', 'Chen Wei', '+65 9123 4567', '1985-03-12', 'Insomnia'),
('T0123456G', 'Lim Sook Yee', '+65 8765 4321', '2001-07-20', 'Fatigue');

-- Treatment types & rooms
INSERT INTO treatment_types (name, duration_minutes) VALUES ('Acupuncture', 60);
INSERT INTO rooms (room_number, room_type) VALUES ('A1', 'Acupuncture Room');

-- Appointment
INSERT INTO appointments (patient_nric, physician_staff_id, room_id, treatment_type_id, scheduled_datetime)
VALUES ('S8512345A', 2, 1, 1, '2025-10-20 10:00:00');

-- Add a new patient
INSERT INTO patients (nric, name, phone, date_of_birth, chief_complaint)
VALUES ('F9876543X', 'Aisha Binte Mohd', '+65 9888 7777', '1998-11-05', 'Migraine');
