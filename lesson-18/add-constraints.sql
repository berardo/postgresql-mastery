-- Preparation: just the bare minimum to allow explaining the lesson's target
CREATE SCHEMA missing_constraints;
SET search_path TO missing_constraints;
CREATE TABLE customers (customer_id INTEGER GENERATED ALWAYS AS IDENTITY);
CREATE TABLE products (product_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, sku VARCHAR(50));
CREATE TABLE orders (order_id SERIAL PRIMARY KEY, total_amount NUMERIC(10,2)); -- Let's also have a SERIAL column
CREATE TABLE order_items (order_id INTEGER, product_id INTEGER, PRIMARY KEY (order_id, product_id));

-- Adding a primary key constraint
ALTER TABLE customers 
  ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

-- Adding a unique constraint
ALTER TABLE products 
  ADD CONSTRAINT uq_products_sku UNIQUE (sku);

-- Adding a check constraint
ALTER TABLE orders 
  ADD CONSTRAINT chk_orders_total CHECK (total_amount >= 0);

-- Create an index before adding a constraint
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
-- Adding a foreign key constraint
ALTER TABLE order_items 
  ADD CONSTRAINT fk_order_items_orders 
  FOREIGN KEY (order_id) REFERENCES orders(order_id);


-- Preparation:
INSERT INTO products (sku) VALUES ('TAB450-WHT-32GB');
INSERT INTO orders (total_amount) VALUES (999.99);
-- Valid order_id (foreign key was added previously)
-- Invalid produc_id (there's no product whose product_id is 555)
-- There's no FOREIGN KEY constraint to prevent this anomaly!!!!!
INSERT INTO order_items (order_id, product_id) VALUES (1, 555);
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

-- Add foreign key without validating existing data
ALTER TABLE order_items 
  ADD CONSTRAINT fk_order_items_products 
  FOREIGN KEY (product_id) REFERENCES products(product_id) NOT VALID;