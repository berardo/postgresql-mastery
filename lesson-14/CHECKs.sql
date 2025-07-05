CREATE TABLE products (
    name varchar(100),
    price decimal(10,2),
    discount_price decimal(10,2),
    status char(1),
    CONSTRAINT valid_price CHECK (price > 0),
    CONSTRAINT valid_discount CHECK (discount_price <= price),
    CONSTRAINT valid_status CHECK (status IN ('A', 'I', 'D'))
);

INSERT INTO products (name, price, discount_price, status) VALUES
  ('Standard Widget', 25.00, 20.00, 'A'),
  ('Deluxe Widget', 50.00, 45.00, 'I')
RETURNING (name, price, discount_price, status);

INSERT INTO products (name, price, discount_price, status) VALUES
  ('Faulty Widget', 0.00, 0.00, 'A');

INSERT INTO products (name, price, discount_price, status) VALUES
  ('Overpriced Widget', 30.00, 35.00, 'D');

INSERT INTO products (name, price, discount_price, status) VALUES
  ('Unknown Widget', 15.00, 10.00, 'X');

