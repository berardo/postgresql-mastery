-- Drop the existing primary key
ALTER TABLE products DROP CONSTRAINT products_pkey;

-- Add a new primary key (explicit naming convention)
ALTER TABLE products ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
-- Or (implicit naming convention):
ALTER TABLE products ADD PRIMARY KEY (product_id);

-- Add a new foreign key (explicit naming convention)
ALTER TABLE order_items ADD CONSTRAINT fk_order_items_products 
  FOREIGN KEY (product_id) REFERENCES products(product_id) NOT VALID;
-- Or (implicit naming convention)
ALTER TABLE order_items ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Remove a foreign key
ALTER TABLE order_items 
DROP CONSTRAINT fk_order_items_products;