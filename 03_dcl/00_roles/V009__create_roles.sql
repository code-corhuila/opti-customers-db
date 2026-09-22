-- Roles carry permissions, never credentials: they cannot log in and have no password.
-- The users with credentials are created by the infrastructure from secrets, and are granted one of these.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'customers_reader') THEN
        CREATE ROLE customers_reader NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'customers_writer') THEN
        CREATE ROLE customers_writer NOLOGIN;
    END IF;
END
$$;
