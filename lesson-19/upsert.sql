-- Create a products table
CREATE TABLE products (
  product_id INT GENERATED ALWAYS AS IDENTITY,
  code TEXT UNIQUE,
  name TEXT NOT NULL,
  price NUMERIC(10,2) NOT NULL,
  PRIMARY KEY (product_id)
);

-- Insert initial products
INSERT INTO products (code, name, price) VALUES
  ('A123', 'Widget', 19.99),
  ('B456', 'Gadget', 24.99);

INSERT INTO products (code, name, price)
VALUES ('A123', 'Premium Widget', 29.99)
ON CONFLICT (code) 
DO UPDATE SET 
    name = EXCLUDED.name,
    price = EXCLUDED.price;

-- This command doesn't insert or update any record
INSERT INTO products (code, name, price)
VALUES ('B456', 'Super Gadget', 34.99)
ON CONFLICT (code) DO NOTHING;