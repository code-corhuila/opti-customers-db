-- Demo data for DEVELOPMENT only. It runs when the placeholder seedDemoData is "true"
-- (FLYWAY_PLACEHOLDERS_SEEDDEMODATA=true, set by opti-infra/env/.env.develop.example); in qa and main it is a no-op.
-- Idempotent: running it again changes nothing. The ids are fixed so the products and sales demos can refer to them.
DO $seed$
BEGIN
    IF '${seedDemoData}' = 'true' THEN
        INSERT INTO customers.patient (id, document_type, document_number, first_name, last_name, phone, email, eps, city, status, last_control_date)
        VALUES
            ('11111111-1111-4111-8111-111111111111', 'CC', '1075243890', 'Laura Marcela', 'Ortega Ruiz', '3104582291', 'laura.ortega@gmail.com', 'Sanitas', 'Neiva', 'ACTIVE', DATE '2026-03-10'),
            ('22222222-2222-4222-8222-222222222222', 'CC', '1075601122', 'Andres Felipe', 'Rojas Medina', '3218890145', 'andresfr@outlook.com', 'Nueva EPS', 'Neiva', 'ACTIVE', DATE '2025-06-02'),
            ('33333333-3333-4333-8333-333333333333', 'CC', '55238471', 'Gloria Stella', 'Pena Lozano', '3006721540', 'gloria.pena@gmail.com', 'Compensar', 'Pitalito', 'ACTIVE', DATE '2026-08-15')
        ON CONFLICT (id) DO UPDATE SET
            phone = EXCLUDED.phone,
            email = EXCLUDED.email,
            eps = EXCLUDED.eps,
            city = EXCLUDED.city;
    END IF;
END
$seed$;
