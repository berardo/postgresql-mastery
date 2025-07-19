-- Idempotency: There's no harm in running the same commands MULTIPLE times.
-- The effect is the same as running them only once.
CREATE SCHEMA IF NOT EXISTS inventory;

-- Creating objects only if they don't exist
CREATE TABLE IF NOT EXISTS orders (order_id SERIAL PRIMARY KEY, order_date DATE);
CREATE INDEX IF NOT EXISTS idx_customer_email ON customers(email);
CREATE SEQUENCE IF NOT EXISTS orders_order_id_seq;

-- Creating other objects (we haven't covered)
-- Creating types (relevant for advanced constraint scenarios)
CREATE TYPE IF NOT EXISTS order_status AS ENUM ('pending', 'processing', 'shipped', 'delivered');
-- Creating domains (useful for constraint-like validation)
CREATE DOMAIN IF NOT EXISTS positive_price AS NUMERIC(10,2) CHECK (VALUE > 0);

-- Adding constraints only if they don't exist
ALTER TABLE orders 
ADD CONSTRAINT IF NOT EXISTS pk_orders PRIMARY KEY (order_id);

ALTER TABLE order_items 
ADD CONSTRAINT IF NOT EXISTS fk_order_items_orders 
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE products 
ADD CONSTRAINT IF NOT EXISTS chk_products_price_positive 
CHECK (price > 0);

ALTER TABLE customers 
ADD CONSTRAINT IF NOT EXISTS uq_customers_email 
UNIQUE (email);



-- Dropping objects only if they exist
DROP TABLE IF EXISTS temp_orders;
DROP INDEX IF EXISTS idx_obsolete;
DROP CONSTRAINT IF EXISTS chk_price_positive;
DROP SEQUENCE IF EXISTS old_sequence;