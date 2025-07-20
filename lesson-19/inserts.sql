CREATE TABLE employees (
  employee_id INT GENERATED ALWAYS AS IDENTITY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  PRIMARY KEY (employee_id)
);

INSERT INTO employees (first_name, last_name, email) VALUES 
    ('Mary', 'Johnson', 'mary.j@example.com'),
    ('Peter', 'Wilson', 'p.wilson@example.com'),
    ('Susan', 'Brown', 'susan.brown@example.com');