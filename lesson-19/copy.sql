COPY employees (first_name, last_name, email, department, salary)
FROM '/var/lib/postgresql/employees.csv'
WITH (FORMAT csv, HEADER true);

COPY employees (first_name, last_name, email, department, salary)
FROM '/var/lib/postgresql/employees-tab.csv'
WITH (FORMAT text, DELIMITER E'\t', HEADER true);

COPY employees (first_name, last_name, email, department, salary)
FROM '/var/lib/postgresql/employees-quotes.csv'
WITH (FORMAT CSV, DELIMITER '|', QUOTE '"', HEADER true);