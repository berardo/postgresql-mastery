-- Preparation
UPDATE employees SET department = 'Marketing' WHERE department = 'MARKETING';
INSERT INTO employees (first_name, last_name, email, department, salary) VALUES
  ('Peggy', 'Olson', 'peggy.olson@sterlingcooper.com', 'Marketing', 7000),
  ('Samantha', 'Jones', 'samantha.jones@jonespr.com', 'Marketing', 10000);

-- DELETE all employees in Marketing
BEGIN;
DELETE FROM employees WHERE department = 'Marketing';
ROLLBACK;

DELETE FROM products WHERE price > 1000;
DELETE FROM orders WHERE order_date < CURRENT_DATE - INTERVAL '30 days';


-- Preparation:
-- INSERT an inactive customer
-- INSERT an order whose customer_id is the inactive customer's customer_id

-- DELETE USING data from another table
DELETE FROM orders
USING customers
WHERE orders.customer_id = customers.customer_id
  AND customers.status = 'inactive';

-- DELETE with subqueries
DELETE FROM orders
WHERE customer_id IN (
    SELECT customer_id
    FROM customers
    WHERE status = 'inactive'
);

-- Preparation:
ALTER TABLE orders DROP CONSTRAINT orders_customer_id_fkey;
ALTER TABLE orders ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;
INSERT INTO orders(customer_id) VALUES (1005);
-- Delete again to check the CASCADE option
DELETE FROM customers WHERE status = 'inactive';

DELETE FROM employees
WHERE department = 'Marketing'
RETURNING employee_id, first_name, last_name, department, hire_date;