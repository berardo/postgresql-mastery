CREATE SCHEMA identity;
CREATE TABLE identity.users (
    user_id BIGINT GENERATED ALWAYS AS IDENTITY,
    username VARCHAR(100)
);

-- This works with both ALWAYS and BY DEFAULT
INSERT INTO identity.users (username) VALUES ('alice');

-- This equivalent to the previous command
INSERT INTO identity.users (user_id, username) 
VALUES (DEFAULT, 'bob');

-- This, on the other hand, only works with BY DEFAULT
INSERT INTO identity.users (user_id, username) 
VALUES (1, 'bob');