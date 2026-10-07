-- patient: the aggregate of the customers domain. No foreign keys here, they go in 04_alter.
CREATE TABLE customers.patient (
    id                uuid        NOT NULL,
    document_type     text        NOT NULL,
    document_number   text        NOT NULL,
    first_name        text        NOT NULL,
    last_name         text        NOT NULL,
    phone             text        NOT NULL,
    email             text,
    eps               text        NOT NULL,
    city              text,
    birth_date        date,
    status            text        NOT NULL DEFAULT 'ACTIVE',
    last_control_date date        NOT NULL,
    created_at        timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_patient PRIMARY KEY (id),
    CONSTRAINT uq_patient_document UNIQUE (document_type, document_number),
    CONSTRAINT chk_patient_document_type CHECK (document_type IN ('CC', 'CE', 'TI', 'PASSPORT')),
    CONSTRAINT chk_patient_document_number CHECK (document_number ~ '^[A-Za-z0-9]{5,20}$'),
    CONSTRAINT chk_patient_first_name CHECK (char_length(first_name) BETWEEN 2 AND 100),
    CONSTRAINT chk_patient_last_name CHECK (char_length(last_name) BETWEEN 2 AND 100),
    CONSTRAINT chk_patient_phone CHECK (phone ~ '^\+?[0-9]{7,15}$'),
    CONSTRAINT chk_patient_email CHECK (email IS NULL OR char_length(email) <= 160),
    CONSTRAINT chk_patient_eps CHECK (char_length(eps) BETWEEN 2 AND 80),
    CONSTRAINT chk_patient_city CHECK (city IS NULL OR char_length(city) <= 80),
    CONSTRAINT chk_patient_status CHECK (status IN ('ACTIVE', 'CONTROL_OVERDUE', 'INACTIVE'))
);

COMMENT ON TABLE customers.patient IS 'A person attended by the optical shop. Unique by (document_type, document_number).';
COMMENT ON COLUMN customers.patient.status IS 'ACTIVE, CONTROL_OVERDUE (last control older than 12 months, set by the worker) or INACTIVE.';
COMMENT ON COLUMN customers.patient.last_control_date IS 'Date of the last optical control; drives the overdue-control job.';
