-- Preparation
-- Create a new_products table with product_id, name and price and insert 5 random values into this table
CREATE TABLE new_products (
  product_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50) NOT NULL,
  price NUMERIC(10,2) NOT NULL CHECK(price>=0)
);
INSERT INTO new_products (name, price) VALUES
  ('Wireless Mouse', 45.99),
  ('USB-C Hub', 89.50),
  ('Desktop Calculator', 24.95),
  ('A4 Paper Ream', 12.50),
  ('Desk Organizer', 35.75);
-- Add the columns: created_at and updated_at DEFAULT CURRENT_TIMESTAMP
ALTER TABLE products
  ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP - INTERVAL '12 hours';

-- Merge new_products into existing products
MERGE INTO products p
USING new_products np
ON p.product_id = np.product_id
WHEN MATCHED THEN
  UPDATE SET name = np.name,
    price = np.price,
    updated_at = CURRENT_TIMESTAMP
WHEN NOT MATCHED BY TARGET THEN
  INSERT (name, price, created_at, updated_at)
  VALUES (np.name, np.price, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Preparation
-- Create a table customer_updates with customer_id, phone and email
CREATE TABLE customer_updates (
  customer_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(50)
);
-- Alter sequence to begin with 1001
ALTER SEQUENCE customer_updates_customer_id_seq RESTART WITH 1001;
-- Insert two pairs of email and phone
INSERT INTO customer_updates (email, phone)
VALUES ('susan.nasus@example.com', '0456 777 888'),
  ('lion.noil@example.com', '0400 111 222');

-- Merge to align our main customers table with data from another one
MERGE INTO customers c
USING customer_updates cu
ON c.customer_id = cu.customer_id
WHEN MATCHED THEN
  UPDATE SET email = cu.email,
    phone = cu.phone,
    last_updated = CURRENT_TIMESTAMP;

-- Preparation:
-- Create a table discontinued_products with product_id INTEGER and anything else you want
-- Insert a couple of random product ids that exist in our products table to simulate matches

-- Purge products that also exist in discontinued_products table
MERGE INTO products p
USING discontinued_products dp
ON p.product_id = dp.product_id
WHEN MATCHED THEN
  DELETE;

-- Preparation:
-- Create a table product_updates to represent a list of new product prices
CREATE TABLE product_updates (
  product_id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
  price NUMERIC(10,2) NOT NULL
);
-- Populate product_updates with random pairs of product_id and price
INSERT INTO product_updates (product_id, price)
  SELECT product_id, price FROM products where product_id = 105;
INSERT INTO product_updates (product_id, price) 
  SELECT product_id, price + (random() * 10) FROM products where product_id > 105;

-- Our task is to merge the new product prices from product_updates into our main products table 
MERGE INTO products p
USING product_updates pu
ON p.product_id = pu.product_id
WHEN MATCHED AND p.price <> pu.price THEN
  UPDATE SET 
    price = pu.price,
    updated_at = CURRENT_TIMESTAMP;


-- Preparation:
-- Create a leads table with lead_id, email and created_at (DEFAULT CURRENT TIMESTAMP)
 CREATE TABLE leads (
  lead_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(50),
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
-- Add status column to customers (CHECK 'active' OR 'inactive')
ALTER TABLE customers ADD COLUMN status VARCHAR(10) CHECK(status IN ('active', 'inactive'));
-- Populate / update involved tables as per SELECT results in the video
INSERT INTO customers (first_name, last_name, email, last_updated, status)
  VALUES ('Inactive', 'Guy', 'inactive@example.com', CURRENT_TIMESTAMP, 'inactive');
INSERT INTO leads (first_name, last_name, email, phone)
  SELECT first_name, last_name, email, phone FROM customers;
UPDATE leads
  SET phone = '0411 222 333',
  created_at = CURRENT_TIMESTAMP - INTERVAL '7 days'
  WHERE email = 'inactive@example.com';
UPDATE leads SET phone = '0456 888 777'  WHERE email = 'susan.nasus@example.com';
UPDATE leads SET phone = '0400 999 888'  WHERE email = 'lion.noil@example.com';


-- Update with WHEN MATCHED AND
MERGE INTO customers AS c
USING leads AS l
ON c.email = l.email
WHEN MATCHED AND (c.last_updated < l.created_at OR c.status = 'inactive') THEN
  UPDATE SET first_name = l.first_name,
  last_name = l.last_name,
  phone = l.phone,
  last_updated = CURRENT_TIMESTAMP;

-- Multiple WHEN MATCHED AND
MERGE INTO customers AS c
USING leads AS l
ON c.email = l.email
WHEN MATCHED AND c.last_updated < l.created_at THEN
  UPDATE SET first_name = l.first_name,
    last_name = l.last_name,
    phone = l.phone,
    last_updated = CURRENT_TIMESTAMP
WHEN MATCHED AND c.status = 'inactive' THEN
  DELETE;


-- Preparation:
-- Add score INTEGER DEFAULT 70 column to leads table
-- Insert a new lead with score 90

-- Merge new leads into customers only if their score is above 80
MERGE INTO customers c
USING leads l
ON c.email = l.email
WHEN NOT MATCHED BY TARGET AND l.score > 80 THEN
  INSERT (first_name, last_name, email, last_updated)
  VALUES (l.first_name, l.last_name, l.email, CURRENT_TIMESTAMP);

-- Preparation:
-- Insert more products on product_updates if you don't want to lose them on products :)

-- Be careful: This example can delete some of your products ;)
MERGE INTO products AS inventory
USING product_updates AS pu
ON inventory.product_id = pu.product_id
WHEN MATCHED THEN
  UPDATE SET 
    quantity = inventory.quantity + pu.quantity_change,
    updated_at = CURRENT_TIMESTAMP
WHEN NOT MATCHED THEN
  INSERT (price, quantity, updated_at)
  VALUES (pu.price, pu.quantity_change, CURRENT_TIMESTAMP)
WHEN NOT MATCHED BY SOURCE AND inventory.updated_at < CURRENT_DATE - INTERVAL '1 year' THEN
  DELETE;

