
-- Impact Assessment Before Large Deletions

-- Record size
SELECT COUNT(*) FROM customers -- WHERE deletion_condition;

-- Estimate the size of data to be removed
SELECT pg_total_relation_size('customers') AS total_size,
 pg_size_pretty(pg_total_relation_size('customers')) as pretty_total_size;