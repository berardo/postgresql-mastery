-- Preparation: more advanced code just to list existing constraint in our schema
-- Add HSTORE extension to enable simple key-value pairs --- Look at you :)
CREATE EXTENSION IF NOT EXISTS hstore;
-- Query to check through the catalogue what constraints exist
CREATE OR REPLACE VIEW all_existing_constraints AS SELECT c.relname AS table_name,
  con.conname AS constraint_name,
  ('c=>Check,f=>"Foreign Key",p=>"Primary Key",u=>Unique'::hstore) -> con.contype AS constraint_type,
  pg_get_constraintdef(con.oid) AS constraint_definition
FROM pg_constraint con JOIN pg_class c ON con.conrelid = c.oid JOIN pg_namespace n ON c.relnamespace = n.oid
WHERE n.nspname = 'missing_constraints'
ORDER BY c.relname, con.conname;


-- Drop the existing constraint
ALTER TABLE order_items DROP CONSTRAINT fk_order_items_orders;

-- Add it back with different properties
ALTER TABLE order_items 
  ADD CONSTRAINT fk_order_items_orders 
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
  ON DELETE CASCADE;

-- Remove a constraint
ALTER TABLE products DROP CONSTRAINT products_pkey CASCADE;

-- Don't forget to re-add 
-- Choose one of the two below:
ALTER TABLE products ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);
-- ALTER TABLE products ADD PRIMARY KEY (product_id);

ALTER TABLE order_items 
  ADD CONSTRAINT fk_order_items_products 
  FOREIGN KEY (product_id) REFERENCES products(product_id) NOT VALID;