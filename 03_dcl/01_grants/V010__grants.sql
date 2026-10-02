GRANT USAGE ON SCHEMA customers TO customers_reader, customers_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA customers TO customers_reader;
GRANT SELECT, INSERT, UPDATE ON customers.patient, customers.optical_formula, customers.idempotency_key TO customers_writer;
