MODEL (
  name omop.care_site,
  kind INCREMENTAL_BY_UNIQUE_KEY (
    unique_key care_site_id
  ),
  grain (
    care_site_id
  ),
  columns (
    care_site_id INTEGER,
    care_site_name VARCHAR(255),
    place_of_service_concept_id INTEGER,
    location_id INTEGER,
    care_site_source_value VARCHAR(50),
    place_of_service_source_value VARCHAR(50)
  )
);

-- Extract relevant columns from the omop.organizations table
WITH source AS (
    SELECT 
        Id AS care_site_source_value,
        NAME AS care_site_name
    FROM omop.organizations
)

SELECT
    ROW_NUMBER() OVER (ORDER BY care_site_source_value) AS care_site_id,
    care_site_name,
    NULL AS place_of_service_concept_id,
    NULL AS location_id,
    care_site_source_value,
    NULL AS place_of_service_source_value
FROM source;