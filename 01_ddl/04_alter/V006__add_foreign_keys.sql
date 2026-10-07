-- Foreign keys live here, after every table exists, so table order never matters.
-- A patient with formulas cannot be deleted: history is kept (RESTRICT).
ALTER TABLE customers.optical_formula
    ADD CONSTRAINT fk_optical_formula_patient
    FOREIGN KEY (patient_id) REFERENCES customers.patient (id) ON DELETE RESTRICT;
