-- Violating a NOT NULL constraint
INSERT INTO employees (first_name, email)
VALUES ('Jane', 'jane.doe@example.com');

-- Violating a unique constraint on email
INSERT INTO employees (first_name, last_name, email)
VALUES ('John', 'Smith', 'johnsmith@example.com');

-- Data type mismatch
INSERT INTO employees (first_name, last_name, email, salary)
VALUES ('Mark', 'Taylor', 'mark.t@example.com', 'five thousand');