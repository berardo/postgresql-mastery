CREATE SCHEMA example;

-- Create products table
CREATE TABLE example.products (
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

CREATE INDEX idx_product_name ON example.products(name);

-- Create customers table
CREATE TABLE example.customers (
  customer_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50),
  email VARCHAR(100) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create orders table
CREATE TABLE example.orders (
  order_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  customer_id INTEGER REFERENCES example.customers(customer_id),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(12,2) CHECK (total_amount >= 0)
);

CREATE INDEX idx_order_customer ON example.orders(customer_id, order_date);

-- Create order_items table
CREATE TABLE example.order_items (
  order_id INTEGER REFERENCES example.orders(order_id),
  product_id INTEGER REFERENCES example.products(product_id),
  quantity INTEGER CHECK (quantity > 0),
  price_per_unit DECIMAL(10,2),
  PRIMARY KEY (order_id, product_id)
);