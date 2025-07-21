-- Preparation:
-- Add the following columns to customers: first_name, last_name, loyalty_points and last_purchase_date
ALTER TABLE customers
  ADD COLUMN IF NOT EXISTS first_name VARCHAR(50),  -- PostgreSQL 18+ will allow NOT NULL NOT VALID
  ADD COLUMN IF NOT EXISTs last_name VARCHAR(50), -- PostgreSQL 18+ will allow NOT NULL NOT VALID
  ADD COLUMN loyalty_points INTEGER DEFAULT 50,
  ADD COLUMN last_purchase_date DATE;
-- Update existing customers last_purchase_date to 2 days ago (see the INTERVAL on command below)
UPDATE customers SET last_purchase_date = CURRENT_DATE - INTERVAL '2 days';
UPDATE customers SET first_name = 'Susan', last_name = 'Nasus' WHERE customer_id = 1001;
UPDATE customers SET first_name = 'Lion', last_name = 'Noil' WHERE customer_id = 1002;

ALTER TABLE customers
  ALTER COLUMN first_name SET NOT NULL,
  ALTER COLUMN last_name SET NOT NULL;

UPDATE customers
SET loyalty_points = loyalty_points + 100
WHERE last_purchase_date > CURRENT_DATE - INTERVAL '30 days'
RETURNING customer_id, first_name, last_name, loyalty_points;