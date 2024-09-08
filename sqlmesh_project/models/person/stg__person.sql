MODEL (
  name omop.stg__person,
  kind VIEW,
  grain (
    person_source_value
  )
);

-- Extract relevant columns from the omop.patients table
WITH source AS (
    SELECT
        Id AS person_source_value,
        BIRTHDATE,
        CITY,
        STATE,
        COUNTY,
        ZIP,
        GENDER AS gender_source_value,
        RACE AS race_source_value,
        ETHNICITY AS ethnicity_source_value
    FROM omop.patients
),
-- Map gender, race, and ethnicity values to concept IDs; extract birthdate parts
mapping AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY person_source_value) AS person_id,
        person_source_value,
        CASE gender_source_value
            WHEN 'M' THEN 8507
            WHEN 'F' THEN 8532
            ELSE 0
        END AS gender_concept_id,
        EXTRACT(YEAR FROM BIRTHDATE::date)::INT AS year_of_birth,
        EXTRACT(MONTH FROM BIRTHDATE::date)::INT AS month_of_birth,
        EXTRACT(DAY FROM BIRTHDATE::date)::INT AS day_of_birth,
        CASE race_source_value
            WHEN 'white' THEN 8527
            WHEN 'black' THEN 8516
            WHEN 'asian' THEN 8515
            WHEN 'hawaiian' THEN 8557
            ELSE 0 -- Unmapped or unknown race
        END AS race_concept_id,
        CASE ethnicity_source_value
            WHEN 'nonhispanic' THEN 38003564
            WHEN 'hispanic' THEN 38003563
        END AS ethnicity_concept_id
    FROM source
),
-- Combined all mapped data
final AS (
    SELECT
        m.person_id AS person_id,
        m.gender_concept_id AS gender_concept_id,
        m.year_of_birth AS year_of_birth,
        m.month_of_birth AS month_of_birth,
        m.day_of_birth AS day_of_birth,
        m.race_concept_id AS race_concept_id,
        m.ethnicity_concept_id AS ethnicity_concept_id,
        s.person_source_value AS person_source_value,
        s.gender_source_value AS gender_source_value,
        s.race_source_value AS race_source_value,
        s.ethnicity_source_value AS ethnicity_source_value
    FROM source s
    JOIN mapping m
        ON s.person_source_value = m.person_source_value
)

SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    race_concept_id,
    ethnicity_concept_id,
    person_source_value,
    gender_source_value,
    race_source_value,
    ethnicity_source_value
FROM final;