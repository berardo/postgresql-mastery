CREATE TABLE orders (
  order_date timestamp NOT NULL,
  shipping_address text NOT NULL,
  notes text -- This column can contain NULL
);

-- DML Command. Don't worry for now but notice a null ----->----->----->----->------
INSERT INTO orders (order_date, shipping_address, notes)                       --  |
VALUES                                                                         --  |
  (CURRENT_TIMESTAMP - INTERVAL '1 day', '1 Pitt St', 'this entry has notes'), --  |
  (CURRENT_TIMESTAMP, null, null); -- Right here! <-----<-----<-----<---  |

SELECT * FROM orders;