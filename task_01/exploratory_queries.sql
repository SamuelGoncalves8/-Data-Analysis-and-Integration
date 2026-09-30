USE staging;

-- Distinct countries per source
SELECT country_iso3, country_name, COUNT(*) AS rows_number, MIN(year) AS first_year, MAX(year) AS last_year
FROM maddison_indicators
GROUP BY country_iso3, country_name
ORDER BY country_iso3;

SELECT country_iso3, country_name, COUNT(*) AS rows_number, MIN(year) AS first_year, MAX(year) AS last_year
FROM wdi_indicators
GROUP BY country_iso3, country_name
ORDER BY country_iso3;
 
SELECT country_iso3, country_name, COUNT(*) AS rows_number, MIN(year) AS first_year, MAX(year) AS last_year
FROM historical_events
GROUP BY country_iso3, country_name
ORDER BY country_iso3;

-- Number of entities per source
SELECT COUNT(DISTINCT country_iso3) AS countries_maddison FROM maddison_indicators;
SELECT COUNT(DISTINCT country_iso3) AS countries_wdi FROM wdi_indicators;
SELECT COUNT(DISTINCT country_iso3) AS countries_historical FROM historical_events;


-- Year ranges
SELECT MIN(year) AS min_year_maddison, MAX(year) AS max_year_maddison, COUNT(DISTINCT year) AS distinct_years FROM maddison_indicators;
SELECT MIN(year) AS min_year_wdi, MAX(year) AS max_year_wdi, COUNT(DISTINCT year) AS distinct_years FROM wdi_indicators;
SELECT MIN(year) AS min_year_historical, MAX(year) AS max_year_historical, COUNT(DISTINCT year) AS distinct_years FROM historical_events;

-- Data integrity
-- Number of rows
SELECT COUNT(*) AS total_rows_maddison FROM maddison_indicators;
SELECT COUNT(*) AS total_rows_wdi FROM wdi_indicators;
SELECT COUNT(*) AS total_rows_historical FROM historical_events;

-- Duplicate keys
SELECT country_iso3, indicator_code, year, COUNT(*) AS `number`
FROM maddison_indicators
GROUP BY country_iso3, indicator_code, year HAVING `number` > 1;
 
SELECT country_iso3, indicator_code, year, COUNT(*) AS `number`
FROM wdi_indicators
GROUP BY country_iso3, indicator_code, year HAVING `number` > 1;

-- Checking if there are events out of the year range
SELECT COUNT(*) AS outside_window
FROM historical_events WHERE year < 1900 OR year > 2025;


-- Temporal and geographic coverage 
-- Checking missing values, countries, year span (the ones that have data), value range
SELECT indicator_code, indicator_name, COUNT(*) AS rows_number,
       SUM(value IS NULL) AS null_values,
       COUNT(DISTINCT country_iso3) AS countries,
       MIN(CASE WHEN value IS NOT NULL THEN year END) AS first_year_with_data,
       MAX(CASE WHEN value IS NOT NULL THEN year END) AS last_year_with_data,
       MIN(value) AS min_value,
       MAX(value) AS max_value
FROM maddison_indicators
GROUP BY indicator_code, indicator_name
ORDER BY indicator_code;

SELECT indicator_code, indicator_name, COUNT(*) AS rows_number,
       SUM(value IS NULL) AS null_values,
       COUNT(DISTINCT country_iso3) AS countries,
       MIN(CASE WHEN value IS NOT NULL THEN year END) AS first_year_with_data,
       MAX(CASE WHEN value IS NOT NULL THEN year END) AS last_year_with_data,
       MIN(value) AS min_value,
       MAX(value) AS max_value
FROM wdi_indicators
GROUP BY indicator_code, indicator_name
ORDER BY indicator_code;

-- In wdi, combinations of country/indicator where all values are null
SELECT country_iso3, indicator_code
FROM wdi_indicators
GROUP BY country_iso3, indicator_code
HAVING COUNT(value) = 0;




