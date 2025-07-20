-- Preparation:
ALTER TABLE employees 
  ADD COLUMN department TEXT DEFAULT 'General',
  ADD COLUMN salary NUMERIC(10,2);

-- Expression: Salary 10% higher than "base" salary
INSERT INTO employees (first_name, last_name, email, department, salary)
VALUES ('William', 'Davis', 'w.davis@example.com','Finance', 5000.00 * 1.1);  

-- Functions: Uppercase Hired 30 days ago
INSERT INTO employees (first_name, last_name, email, department, salary, hire_date)
VALUES (
  'Jennifer', 'Wilson', 'j.wilson@example.com', UPPER('marketing'), 6000.00, 
  CURRENT_DATE - INTERVAL '30 days'
);

-- String concatenation
INSERT INTO employees (first_name, last_name, email, department)
VALUES ('Thomas', 'Anderson', 'thomas.anderson@example.com', 'IT ' || 'Support');