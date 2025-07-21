-- Preparation
-- Altering a sequenc (just as a reminder ;)
ALTER SEQUENCE products_product_id_seq RESTART WITH 101;
INSERT INTO products (code, name, price) VALUES ('C222', 'Regular Item', 40);

-- Basic update
UPDATE products
SET price = 29.99
WHERE product_id = 101;

-- Preparation:
-- Please look at the SELECT below, then pause the video and replicate the scenario:
-- Create the customers table
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(50),
  last_updated TIMESTAMPTZ
);
-- Alter the Sequence to begin with 1001
ALTER SEQUENCE customers_customer_id_seq RESTART WITH 1001;
-- Insert one of more customers
INSERT INTO customers (email, phone, last_updated)
VALUES ('lead@example.com', DEFAULT, CURRENT_TIMESTAMP - INTERVAL '30 days');

-- Update multiple columns
UPDATE customers
SET email = 'whatever@example.com',
phone = '0456 777 888',
last_updated = CURRENT_TIMESTAMP
WHERE customer_id = 1001;

-- Update without WHERE
UPDATE products SET price = price * 1.10;

-- Preparation:
-- Add the missing columns to products
ALTER TABLE products ADD COLUMN feature BOOLEAN default false,
  ADD COLUMN reorder BOOLEAN DEFAULT false,
  ADD COLUMN category VARCHAR(50),
  ADD COLUMN stock_quantity INTEGER DEFAULT 0;

-- Update products in a specific category
UPDATE products
SET featured = true
WHERE category = 'Electronics';

-- Update products with low inventory
UPDATE products
SET reorder = true
WHERE stock_quantity < 4;