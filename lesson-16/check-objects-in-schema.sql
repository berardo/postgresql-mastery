-- Check what objects exist in the schema
-- psql: \dtsi example.*  <--- 'd' describe, 't' table, 's' sequence, 'i' index
-- or query pg_class:
SELECT c.oid, relname, n.nspname AS schema
FROM pg_class c
JOIN pg_namespace n ON c.relnamespace = n.oid
WHERE n.nspname = 'example';

-- Verify dependencies from other schemas
SELECT dependent_ns.nspname as dependent_schema,
  dependent_view.relname as dependent_object
FROM pg_depend
  JOIN pg_rewrite ON pg_depend.objid = pg_rewrite.oid
  JOIN pg_class as dependent_view ON pg_rewrite.ev_class = dependent_view.oid
  JOIN pg_class as source_table ON pg_depend.refobjid = source_table.oid
  JOIN pg_namespace dependent_ns ON dependent_view.relnamespace = dependent_ns.oid
  JOIN pg_namespace source_ns ON source_table.relnamespace = source_ns.oid
WHERE source_ns.nspname = 'example';