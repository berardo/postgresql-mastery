-- Scenario 1: Adding a column without DEFAULT and without NOT NULL (allowing NULLs)
ALTER TABLE example.customers ADD COLUMN address VARCHAR(255);

--Scenatio 2: Adding a column with a non-volatile DEFAULT
ALTER TABLE example.customers ADD COLUMN email_verified BOOLEAN DEFAULT false;

-- Scenario 3: Adding a column with a volatile DEFAULT
ALTER TABLE example.customers ADD COLUMN active_since TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Scenario 4: Adding a NOT NULL column without DEFAULT
   -- To test if table is already populated:
   INSERT INTO example.customers (first_name, last_name, email)
   VALUES('Moana', 'Waialiki', 'm.waialiki@motunui')
   RETURNING (first_name, last_name, email, email_verified, created_at, active_since);
ALTER TABLE example.customers ADD COLUMN country VARCHAR(50) NOT NULL;

-- Scenario 5: Adding a NOT NULL column with a non-volatile DEFAULT
ALTER TABLE example.customers ADD COLUMN country VARCHAR(50) NOT NULL DEFAULT 'Motunui';

-- Scenario 6: Adding a NOT NULL column with a volatile DEFAULT
ALTER TABLE example.customers
  ADD COLUMN free_trial_expiration DATE 
  NOT NULL DEFAULT CURRENT_DATE + INTERVAL '7 days';

ALTER TABLE example.customers
  ADD COLUMN full_name TEXT
  GENERATED ALWAYS AS (first_name || ' ' || last_name) STORED;

