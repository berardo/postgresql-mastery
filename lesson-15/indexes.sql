CREATE SCHEMA idx;
CREATE TABLE idx.products (
  product_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100) NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  discount_price NUMERIC(10,2) DEFAULT 0,
  tax_rate NUMERIC(4,2) DEFAULT 0.1,
  price_with_tax NUMERIC(10,2) GENERATED ALWAYS AS (price * (1 + tax_rate)) STORED,
  status CHAR(1),
  CONSTRAINT valid_price CHECK (price > 0),
  CONSTRAINT valid_discount CHECK (discount_price <= price),
  CONSTRAINT valid_status CHECK (status IN ('A', 'I', 'D'))
);
-- Basic index on a single column
-- Do not prefix index names with schemas as they're created on the same schema of the table 
CREATE INDEX idx_product_name ON idx.products(name);

CREATE TABLE idx.orders (
  order_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  customer_id INTEGER REFERENCES fks.customers(customer_id),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Index on multiple columns
CREATE INDEX idx_order_customer ON idx.orders(customer_id, order_date);

-- Create index only if it doesn't exist
CREATE INDEX IF NOT EXISTS idx_product_price ON products(price);

SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'products' AND schemaname = 'idx';