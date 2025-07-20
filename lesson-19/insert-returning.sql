INSERT INTO employees (first_name, last_name, email)
VALUES ('James', 'Taylor', 'james.t@example.com')
RETURNING employee_id, first_name, last_name;

INSERT INTO employees (first_name, last_name, email)
VALUES ('David', 'Miller', 'david.m@example.com')
RETURNING *;