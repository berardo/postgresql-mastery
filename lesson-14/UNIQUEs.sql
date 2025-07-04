CREATE TABLE employees (
  email varchar(100) UNIQUE, -- column level - single column
  phone varchar(20) UNIQUE,  -- column level - single column
  country_code char(2),
  national_id varchar(30),
  -- table level - one or multiple columns
  CONSTRAINT unique_country_nationalid UNIQUE (country_code, national_id)
);

INSERT INTO employees (email, phone, country_code, national_id)
VALUES
  ('janne.doe@example.com', '+61400111222', 'AU', '12345000'),
  ('john.doe@example.com', '+61400222333', 'AU', '12345999'),
  ('fulano@example.com', '+5599998888', 'BR', '12345000');

SELECT * FROM employees;

INSERT INTO employees (email, phone, country_code, national_id)
VALUES ('clash-on-phone@example.com', '+61400111222', 'AU', '9999999');

INSERT INTO employees (email, phone, country_code, national_id)
VALUES ('clash-on-id@example.com', '+61411222987', 'AU', '12345000');