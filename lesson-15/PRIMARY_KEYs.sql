CREATE SCHEMA column_level;
CREATE TABLE column_level.products (
    product_id integer PRIMARY KEY, -- column-level constraint declaration
    sku varchar(50), -- stock keeping unit (common among retailers) / candidate but not primary key
    name varchar(100) NOT NULL
);

CREATE SCHEMA table_level;
CREATE TABLE table_level.products (
    product_id integer,
    sku varchar(50), -- stock keeping unit (common among retailers) / candidate but not primary key
    name varchar(100) NOT NULL,
    -- table-level constraint declaration
    CONSTRAINT pk_products PRIMARY KEY (product_id)
);

CREATE SCHEMA composite_pks;
CREATE TABLE composite_pks.order_items (
    order_id integer,
    product_id integer,
    quantity integer NOT NULL,
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, product_id)
);