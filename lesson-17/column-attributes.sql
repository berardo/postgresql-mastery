-- Preparation:
ALTER TABLE example.products ADD COLUMN description TEXT;

-- SET a NOT NULL attribute to an existing column
ALTER TABLE example.products 
ALTER COLUMN description SET NOT NULL;

-- DROP a NOT NULL attribute from a column
ALTER TABLE example.products 
ALTER COLUMN description DROP NOT NULL;

-- Preparation:
ALTER TABLE example.customers ADD COLUMN status VARCHAR(20);

-- Add a default value
ALTER TABLE example.customers 
ALTER COLUMN status SET DEFAULT 'active';

-- Change an existing default value
ALTER TABLE example.orders 
ALTER COLUMN order_date SET DEFAULT CURRENT_TIMESTAMP;

-- Remove a default value
ALTER TABLE example.products 
ALTER COLUMN in_stock DROP DEFAULT;

-- Preparation
ALTER TABLE example.products ADD COLUMN full_price NUMERIC(10,2);
-- Set generated columns isn't supported :'(
ALTER TABLE example.products ALTER COLUMN full_price 
SET GENERATED ALWAYS AS (price * (1 + tax_rate)) STORED;

ALTER TABLE example.products DROP COLUMN full_price;
ALTER TABLE example.products ADD COLUMN full_price NUMERIC(10,2)
  GENERATED ALWAYS AS (price * (1 + tax_rate)) STORED;

ALTER TABLE example.products ALTER COLUMN full_price
  SET EXPRESSION AS (price * (1 + tax_rate));

ALTER TABLE example.products 
  ALTER COLUMN full_price DROP EXPRESSION;