CREATE SCHEMA fks;
DROP TABLE IF EXISTS fks.customers;
CREATE TABLE fks.customers (
  customer_id INTEGER NOT NULL UNIQUE,  -- Intentionally not PRIMARY KEY / UNIQUE to check the error
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100)
);

-- Column-level: column_name type REFERENCES other_table(external_unique_column)
CREATE TABLE fks.orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INTEGER REFERENCES fks.customers(customer_id),
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS fks.orders;
-- ON DELETE / ON UPDATE [RESTRICT|CASCADE|SET NULL|SET DEFAULT]
CREATE TABLE fks.orders (
  order_id serial PRIMARY KEY,
  customer_id integer,
  CONSTRAINT fk_customer
    FOREIGN KEY (customer_id) REFERENCES fks.customers(customer_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO fks.customers (customer_id, first_name, last_name, email) VALUES
  (1001, 'Jane', 'Blogs', 'jane.blogs@example.com'),
  (1002, 'John', 'Blogs', 'john.blogs@example.com');

INSERT INTO fks.orders (order_id, customer_id) VALUES
  (1, 1001), (2, 1001), (3, 1002), (4, 1002);

-- Check orders before and after customer deletion
SELECT * FROM fks.orders;
DELETE FROM fks.customers WHERE customer_id = 1001;
SELECT * FROM fks.orders;

UPDATE fks.customers SET customer_id = customer_id * 10
RETURNING (customer_id, first_name, last_name);
SELECT * FROM fks.orders;