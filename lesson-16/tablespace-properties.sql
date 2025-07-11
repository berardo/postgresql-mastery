-- Set storage parameters (note the parentheses)
ALTER TABLESPACE fastspace SET (random_page_cost = 1.1);

-- Reset parameter to default
ALTER TABLESPACE fastspace RESET (random_page_cost);

-- Set multiple parameters at once
ALTER TABLESPACE fastspace SET (random_page_cost = 1.1, seq_page_cost = 1.0);