MODEL (
  name omop.stg__visit_occurrence,
  kind VIEW,
  grain (
    Id
  )
);

-- Extract relevant columns from the omop.encounters table
WITH source AS (
    SELECT
        Id,
        START AS visit_start_datetime,
        STOP AS visit_end_datetime,
        PATIENT,
        ORGANIZATION,
        PROVIDER,
        ENCOUNTERCLASS AS visit_source_value
    FROM omop.encounters
),
-- Map visit_source_value to concepts IDs
mapping AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY Id) AS visit_occurrence_id,
        Id,
        CASE visit_source_value
            WHEN 'inpatient' THEN 9201
            WHEN 'outpatient' THEN 9202
            WHEN 'emergency' THEN 9203
            WHEN 'hospice' THEN 8546
            WHEN 'urgentcare' THEN 8782
            WHEN 'snf' THEN 8863
            WHEN 'home' THEN 581476
            WHEN 'ambulatory' THEN 581478
            WHEN 'virtual' THEN 722455
            ELSE 0
        END AS visit_concept_id
    FROM source
),
-- Combined all mapped data
final AS (
    SELECT
        m.visit_occurrence_id AS visit_occurrence_id,
        s.PATIENT AS PATIENT,                           -- For mapping with the person_id field
        m.visit_concept_id AS visit_concept_id,
        s.visit_start_datetime AS visit_start_datetime,
        s.visit_end_datetime AS visit_end_datetime,
        s.PROVIDER AS PROVIDER,                         -- For mapping with the provider_id field
        s.ORGANIZATION AS ORGANIZATION,                 -- For mapping with the care_site_id field
        s.visit_source_value AS visit_source_value 
    FROM source s
    JOIN mapping m
        ON s.Id = m.Id
)

SELECT
    visit_occurrence_id,
    PATIENT,
    visit_concept_id,
    visit_start_datetime,
    visit_end_datetime,
    PROVIDER,
    ORGANIZATION,
    visit_source_value
FROM final;