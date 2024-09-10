MODEL (
  name omop.provider,
  kind INCREMENTAL_BY_UNIQUE_KEY (
    unique_key provider_source_value
  ),
  columns (
    provider_id INTEGER,
    provider_name VARCHAR(255),
    npi VARCHAR(20),
    dea VARCHAR(20),
    specialty_concept_id INTEGER,
    care_site_id INTEGER,
    year_of_birth INTEGER,
    gender_concept_id INTEGER,
    provider_source_value VARCHAR(50),
    specialty_source_value VARCHAR(50),
    specialty_source_concept_id INTEGER,
    gender_source_value VARCHAR(50),
    gender_source_concept_id INTEGER
  )
);

-- Extract relevant columns from the omop.providers table
WITH source AS (
    SELECT 
        Id AS provider_source_value,
        ORGANIZATION,
        NAME AS provider_name,
        SPECIALITY AS specialty_source_value,
        GENDER AS gender_source_value
    FROM omop.providers
),
-- Map specialty and gender values to concept IDs
mapping AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY provider_source_value) AS provider_id,
        provider_source_value,
        CASE specialty_source_value
            WHEN 'GENERAL PRACTICE' THEN 38004446
            ELSE 0
        END AS specialty_concept_id,
        CASE gender_source_value
            WHEN 'M' THEN 8507
            WHEN 'F' THEN 8532
            ELSE 0
        END AS gender_concept_id
    FROM source
),
-- Map each organization to care_site_id
caresiteID AS (
    SELECT 
        cs.care_site_id AS care_site_id,
        cs.care_site_source_value AS care_site_source_value
    FROM source AS s
    JOIN omop.care_site AS cs
        ON s.ORGANIZATION = cs.care_site_source_value
),
-- Combined all mapped data
final AS (
    SELECT
        m.provider_id AS provider_id,
        s.provider_name AS provider_name,
        m.specialty_concept_id AS specialty_concept_id,
        csid.care_site_id AS care_site_id,
        m.gender_concept_id AS gender_concept_id,
        s.provider_source_value AS provider_source_value,
        s.specialty_source_value AS specialty_source_value,
        s.gender_source_value AS gender_source_value
    FROM source s
    JOIN mapping AS m
        ON s.provider_source_value = m.provider_source_value
    JOIN caresiteID AS csid
        ON s.ORGANIZATION = csid.care_site_source_value
)

SELECT
    provider_id,
    provider_name,
    NULL AS npi,
    NULL AS dea,
    specialty_concept_id,
    care_site_id,
    NULL AS year_of_birth,
    gender_concept_id,
    provider_source_value,
    specialty_source_value,
    NULL AS specialty_source_concept_id,
    gender_source_value,
    NULL AS gender_source_concept_id
FROM final;