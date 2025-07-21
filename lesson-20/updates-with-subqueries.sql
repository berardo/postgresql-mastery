-- Preparation
-- Remove NOT NULL constraint from products
ALTER TABLE products ALTER COLUMN price DROP NOT NULL;
-- Insert 2 random products without price
INSERT INTO products (code, name, category) 
VALUES 
  ('F123', 'Random 3', 'Electronics'), 
  ('G234', 'Random 4', 'Electronics');

-- Update products without price as their category's average
UPDATE products p1
SET price = (
    SELECT AVG(price) FROM products p2
    WHERE p2.category = p1.category
)
WHERE price IS NULL;

-- Preparation:
-- Add column membership_level to customers table defaulting to 'Regular'
ALTER TABLE customers ADD COLUMN membership_level VARCHAR(50) DEFAULT 'Regular';
-- Insert a new 'Premium' customer (any email)
INSERT INTO customers (email, membership_level) VALUES ('mr.premium@example.com', 'Premium');
-- Create new orders table with status and a FOREIGN KEY to customers (customer_id)
CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  status VARCHAR(50),
  order_date DATE DEFAULT CURRENT_DATE,
  customer_id INTEGER NOT NULL REFERENCES customers(customer_id)
);

-- Update statuses of all Premium customers' orders as Shipped
UPDATE orders
SET status = 'Shipped'
WHERE customer_id IN (
    SELECT customer_id FROM customers WHERE membership_level = 'Premium'
) AND order_date = CURRENT_DATE;

-- Preparation:
-- Add table departments
CREATE TABLE departments (
  department_id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(50) NOT NULL UNIQUE,
  performance_rating SMALLINT DEFAULT 0
);
-- Add new foreign key on employees to departments
ALTER TABLE employees ADD COLUMN department_id INTEGER REFERENCES departments (department_id);

-- Try yourself to make a scenario where this UPDATE finds rows to update
UPDATE employees AS e
SET salary = salary * 1.1
WHERE e.department_id IN (
  SELECT department_id FROM departments AS d WHERE d.performance_rating > 4
);