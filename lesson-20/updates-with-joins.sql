-- Preparation
-- Add column manager_id on employees as a FOREIGN KEY to itself
ALTER TABLE employees ADD COLUMN IF NOT EXISTS manager_id INTEGER REFERENCES employees (employee_id);
-- Update everyone in General and IT Support departments to be managed by Alice Green
UPDATE employees
SET manager_id = (
  -- With this query, we can fetch Alice Green's Id without having to type it directly
  SELECT employee_id FROM employees WHERE first_name = 'Alice' AND last_name = 'Green'
)
WHERE department IN ('General', 'It Support');
-- Update Alice Green's salary (wow, not bad!)
UPDATE employees SET salary = 200000, manager_id = NULL WHERE first_name = 'Alice' AND last_name = 'Green';
-- Define other management relationships as you wish.
-- The more you do, the better the exercise will look :)

UPDATE employees e
SET salary = managers.salary * 0.8
FROM employees managers
WHERE e.manager_id = managers.employee_id;


-- Preparation (remember to pause the video and give it a try):
-- Add columns: is_bestseller (boolean default false) and sales (integer default 0) to products
ALTER TABLE products
  ADD COLUMN IF NOT EXISTS is_bestseller BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS sales INTEGER DEFAULT 0;
-- Update products set random sales. Use this expression: (RANDOM() * 1000)::INTEGER
UPDATE products SET sales = (RANDOM() * 1000)::INTEGER 
  RETURNING product_id, name, category, sales, is_bestseller;
-- Choose any product in the middle of the pack to mark as is_bestseller
UPDATE products SET is_bestseller = true WHERE product_id = 103; -- Change this id appropriately

UPDATE products
SET is_bestseller = true
FROM products p2
WHERE products.category = p2.category AND products.sales > p2.sales AND p2.is_bestseller = true;