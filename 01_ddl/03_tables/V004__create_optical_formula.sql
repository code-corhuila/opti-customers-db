-- optical_formula: a prescription. Only one per patient is current (unique partial index in 10_indexes).
CREATE TABLE customers.optical_formula (
    id                 uuid          NOT NULL,
    patient_id         uuid          NOT NULL,
    od_sphere          numeric(4, 2),
    od_cylinder        numeric(4, 2),
    od_axis            smallint,
    od_addition        numeric(4, 2),
    oi_sphere          numeric(4, 2),
    oi_cylinder        numeric(4, 2),
    oi_axis            smallint,
    oi_addition        numeric(4, 2),
    pupillary_distance numeric(4, 1) NOT NULL,
    lens_type          text          NOT NULL,
    optometrist_name   text          NOT NULL,
    formula_date       date          NOT NULL,
    is_current         boolean       NOT NULL DEFAULT TRUE,
    created_at         timestamptz   NOT NULL DEFAULT now(),
    CONSTRAINT pk_optical_formula PRIMARY KEY (id),
    CONSTRAINT chk_optical_formula_od_sphere CHECK (od_sphere BETWEEN -20 AND 20),
    CONSTRAINT chk_optical_formula_oi_sphere CHECK (oi_sphere BETWEEN -20 AND 20),
    CONSTRAINT chk_optical_formula_od_cylinder CHECK (od_cylinder BETWEEN -10 AND 10),
    CONSTRAINT chk_optical_formula_oi_cylinder CHECK (oi_cylinder BETWEEN -10 AND 10),
    CONSTRAINT chk_optical_formula_od_axis CHECK (od_axis BETWEEN 0 AND 180),
    CONSTRAINT chk_optical_formula_oi_axis CHECK (oi_axis BETWEEN 0 AND 180),
    CONSTRAINT chk_optical_formula_od_addition CHECK (od_addition BETWEEN 0 AND 4),
    CONSTRAINT chk_optical_formula_oi_addition CHECK (oi_addition BETWEEN 0 AND 4),
    CONSTRAINT chk_optical_formula_od_axis_needed CHECK (COALESCE(od_cylinder, 0) = 0 OR od_axis IS NOT NULL),
    CONSTRAINT chk_optical_formula_oi_axis_needed CHECK (COALESCE(oi_cylinder, 0) = 0 OR oi_axis IS NOT NULL),
    CONSTRAINT chk_optical_formula_pd CHECK (pupillary_distance BETWEEN 40 AND 80),
    CONSTRAINT chk_optical_formula_lens_type CHECK (lens_type IN ('MONOFOCAL', 'BIFOCAL', 'PROGRESSIVE', 'OCCUPATIONAL')),
    CONSTRAINT chk_optical_formula_optometrist CHECK (char_length(optometrist_name) BETWEEN 3 AND 150)
);

COMMENT ON TABLE customers.optical_formula IS 'Optical prescription of a patient (OD right eye, OI left eye). Diopters in steps of 0.25.';
COMMENT ON COLUMN customers.optical_formula.is_current IS 'True for the latest formula of the patient; registering a new one clears the previous.';
