-- 1. Complex conversions: Convert string dates to proper date type
-- Example preparation: Table orders with order_date as varchar
CREATE SCHEMA bad1;
CREATE TABLE bad1.orders(order_id SERIAL, order_date VARCHAR(10));
INSERT INTO bad1.orders (order_date) VALUES ('2025-07-13');
SELECT *, pg_typeof(order_date) AS order_date_type FROM bad1.orders;
-- ALTER TABLE ALTER COLUMN TYPE
ALTER TABLE bad1.orders 
  ALTER COLUMN order_date TYPE DATE 
  USING TO_DATE(order_date, 'YYYY-MM-DD');

-- 2. Conditional conversions: Handle mixed date formats in a column
-- Example preparation: Table orders with order_date as varchar
CREATE SCHEMA bad2;
CREATE TABLE bad2.orders(order_id SERIAL, order_date VARCHAR(10));
INSERT INTO bad2.orders (order_date) VALUES ('2025-07-13'), ('14/07/2025'), ('15-07-2025');
SELECT *, pg_typeof(order_date) AS order_date_type FROM bad2.orders;
-- ALTER TABLE ALTER COLUMN TYPE
ALTER TABLE bad2.orders
  ALTER COLUMN order_date TYPE DATE
  USING CASE 
    WHEN order_date ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN TO_DATE(order_date, 'DD/MM/YYYY')
    WHEN order_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN TO_DATE(order_date, 'YYYY-MM-DD')
    WHEN order_date ~ '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN TO_DATE(order_date, 'DD-MM-YYYY')
  END;

-- 3. Default values for incompatible data: Handle mixed date formats in a column with default NULL
-- Example preparation: Table orders with order_date as varchar
CREATE SCHEMA bad3;
CREATE TABLE bad3.orders(order_id SERIAL, order_date VARCHAR(10));
INSERT INTO bad3.orders (order_date) VALUES ('2025-07-13'), ('14/07/2025'), ('15-07-2025'), ('not a date');
SELECT *, pg_typeof(order_date) AS order_date_type FROM bad3.orders;
-- ALTER TABLE ALTER COLUMN TYPE
ALTER TABLE bad3.orders
  ALTER COLUMN order_date TYPE DATE
  USING CASE 
    WHEN order_date ~ '^[0-9]{2}/[0-9]{2}/[0-9]{4}$' THEN TO_DATE(order_date, 'DD/MM/YYYY')
    WHEN order_date ~ '^[0-9]{4}-[0-9]{2}-[0-9]{2}$' THEN TO_DATE(order_date, 'YYYY-MM-DD')
    WHEN order_date ~ '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' THEN TO_DATE(order_date, 'DD-MM-YYYY')
    ELSE NULL
  END;