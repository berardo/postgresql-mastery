CREATE SCHEMA serial_ex1;
CREATE SCHEMA serial_ex2;

-- Table with a SERIAL column
CREATE TABLE serial_ex1.products (
    product_id SERIAL,
    name varchar(100)
);

-- It's the same as:
CREATE SEQUENCE serial_ex2.products_product_id_seq;

CREATE TABLE serial_ex2.products (
    product_id INTEGER NOT NULL DEFAULT nextval('serial_ex2.products_product_id_seq'),
    name varchar(100)
);

ALTER SEQUENCE serial_ex2.products_product_id_seq
    OWNED BY serial_ex2.products.product_id;