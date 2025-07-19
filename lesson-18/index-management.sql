-- Preparation:
SET search_path TO missing_constraints;
-- Adding a regular text column
ALTER TABLE customers ADD COLUMN email VARCHAR(255);
-- Adding a UNIQUE index on the column above (explicit naming method)
CREATE UNIQUE INDEX customers_email_key ON customers(email);
-- These two instructions are equivalent to the single line below:
ALTER TABLE customers ADD COLUMN email VARCHAR(255) UNIQUE;


-- Create new index without blocking operations
CREATE UNIQUE INDEX CONCURRENTLY customers_email_new_key ON customers(email);

-- Drop old index once new one is ready
DROP INDEX CONCURRENTLY customers_email_key;

-- Rename new index to the standard name
ALTER INDEX customers_email_new_key RENAME TO customers_email_key;

-- Rebuild a single index
REINDEX INDEX customers_email_key;

-- Rebuild all indexes on a table
REINDEX TABLE customers;

-- Rebuild all indexes in the database
REINDEX DATABASE shop;
