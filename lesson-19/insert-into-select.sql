-- Preparation
CREATE TABLE active_employees (
  employee_id INT,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  department TEXT,
  last_active_date DATE DEFAULT CURRENT_DATE,
  PRIMARY KEY (employee_id)
);

INSERT INTO active_employees (employee_id, first_name, last_name, department)
SELECT employee_id, first_name, last_name, department
FROM employees 
WHERE salary > 5000;