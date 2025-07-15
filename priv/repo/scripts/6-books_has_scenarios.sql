UPDATE books SET has_scenarios = true;

UPDATE books
SET has_scenarios = false
WHERE id NOT IN (
  SELECT DISTINCT book AS id FROM scenario_resources WHERE resource_type = 0
);
