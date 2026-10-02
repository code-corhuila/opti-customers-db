-- Plain CREATE INDEX is fine here: the tables were created in this same release and are empty.
-- Any later index on a table with data goes in its own migration with CREATE INDEX CONCURRENTLY.

-- fk_optical_formula_patient: every foreign key column has its index.
-- Also serves "formulas of a patient, newest first".
CREATE INDEX idx_optical_formula_patient_date ON customers.optical_formula (patient_id, formula_date DESC, created_at DESC);

-- Rule: only one current formula per patient, enforced by the engine.
CREATE UNIQUE INDEX uq_optical_formula_current ON customers.optical_formula (patient_id) WHERE is_current;

-- GET /patients: newest first, optionally filtered by status.
CREATE INDEX idx_patient_created ON customers.patient (created_at DESC, id DESC);
CREATE INDEX idx_patient_status_created ON customers.patient (status, created_at DESC);

-- Overdue-control job: ACTIVE patients whose last control is older than the cutoff.
CREATE INDEX idx_patient_control_due ON customers.patient (last_control_date) WHERE status = 'ACTIVE';

-- Search by name (case-insensitive, contains).
CREATE INDEX idx_patient_name ON customers.patient (lower(last_name), lower(first_name));
