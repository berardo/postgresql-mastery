CREATE TABLE audit_log (
    event_id SERIAL,  -- Auto increments by default
    event_type VARCHAR(50), -- Accepts and defaults to NULL 
    event_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Current date/time by default
    processed BOOLEAN DEFAULT false -- False by default
);
-- Inserting ALL defaults
INSERT INTO audit_log DEFAULT VALUES;

SELECT * FROM audit_log;
SELECT uuid_generated_v4();