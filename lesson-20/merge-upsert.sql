-- Preparation:
-- ADD column sku UNIQUE to products

-- UPSERT version
INSERT INTO products (sku, name, price)
VALUES ('LAPTOP-15I7-512G-BLK', 'Laptop Pro Black', 999.99)
ON CONFLICT (sku) 
DO UPDATE SET 
  name = EXCLUDED.name,
  price = EXCLUDED.price,
  updated_at = CURRENT_TIMESTAMP;

MERGE INTO products p
USING (VALUES ('LAPTOP-15I7-512G-BLK', 'Laptop Pro Black', 1299.99)) AS np(sku, name, price)
ON p.sku = np.sku
WHEN MATCHED THEN
  UPDATE SET 
    name = np.name,
    price = np.price,
    updated_at = CURRENT_TIMESTAMP
WHEN NOT MATCHED THEN
  INSERT (sku, name, price)
  VALUES (np.sku, np.name, np.price);