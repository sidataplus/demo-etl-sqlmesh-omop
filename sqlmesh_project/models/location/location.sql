MODEL (
  name omop.location,
  kind INCREMENTAL_BY_UNIQUE_KEY (
    unique_key location_id
  ),
  grain (
    location_id
  ),
  columns (
    location_id INTEGER,
    address_1 VARCHAR(50),
    address_2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    zip VARCHAR(10),
    county VARCHAR(50),
    location_source_value VARCHAR(50)
  )
);

-- Extract relevant columns from the omop.patients table
WITH source AS (
    SELECT 
        ADDRESS AS address_1,
        CITY AS city,
        STATE AS state,
        REPLACE(COUNTY, 'County', '') AS county,
        FIPS AS location_source_value,
        ZIP AS zip
    FROM omop.patients
)

SELECT
    ROW_NUMBER() OVER (ORDER BY location_source_value, zip) AS location_id,
    address_1,
    NULL AS address_2,
    city,
    state,
    zip,
    county,
    location_source_value
FROM source;