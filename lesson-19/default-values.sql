-- Preparation:
ALTER TABLE employees ADD COLUMN hire_date DATE NOT NULL DEFAULT CURRENT_DATE;

INSERT INTO employees (first_name, last_name, email, hire_date)
VALUES ('Robert', 'Brown', 'r.brown@example.com', DEFAULT);

INSERT INTO employees (first_name, last_name, email)
VALUES ('Alice', 'Green', 'alice.g@example.com');

-- Let's create a simple log table
CREATE TABLE log_entries (
    log_id INT GENERATED ALWAYS AS IDENTITY,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    message TEXT DEFAULT 'System check',
    PRIMARY KEY (log_id)
);

-- Insert using DEFAULT VALUES
INSERT INTO log_entries DEFAULT VALUES;