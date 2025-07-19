-- Find objects dependent on a sequence
SELECT dependent_ns.nspname as schema_name,
       dependent_view.relname as object_name,
       a.attname as referenced_column_name
FROM pg_depend d
JOIN pg_rewrite r ON r.oid = d.objid
JOIN pg_class dependent_view ON dependent_view.oid = r.ev_class
JOIN pg_class source_table ON source_table.oid = d.refobjid
JOIN pg_namespace dependent_ns ON dependent_view.relnamespace = dependent_ns.oid
JOIN pg_namespace source_ns ON source_table.relnamespace = source_ns.oid
LEFT JOIN pg_attribute a ON a.attrelid = source_table.oid AND a.attnum = d.refobjsubid
WHERE source_table.relname = 'customers_customer_id_seq'
AND source_ns.nspname = 'missing_constraints';