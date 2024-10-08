MODEL (
  name omop.person,
  kind INCREMENTAL_BY_UNIQUE_KEY (
    unique_key person_id
  ),
  columns (
    person_id INTEGER,
    gender_concept_id INTEGER,
    year_of_birth INTEGER,
    month_of_birth INTEGER,
    day_of_birth INTEGER,
    birth_datetime TIMESTAMP,
    race_concept_id INTEGER,
    ethnicity_concept_id INTEGER,
    location_id INTEGER,
    provider_id INTEGER,
    care_site_id INTEGER,
    person_source_value VARCHAR(50),
    gender_source_value VARCHAR(50),
    gender_source_concept_id INTEGER,
    race_source_value VARCHAR(50),
    race_source_concept_id INTEGER,
    ethnicity_source_value VARCHAR(50),
    ethnicity_source_concept_id INTEGER
  ),
  grain (
    person_id
  ),
  audits (UNIQUE_VALUES(columns = (
    person_id
  )), UNIQUE_VALUES(columns = (
    person_source_value
  )))
);

SELECT
    person_id,
    gender_concept_id,
    year_of_birth,
    month_of_birth,
    day_of_birth,
    NULL AS birth_datetime,
    race_concept_id,
    ethnicity_concept_id,
    NULL AS location_id,
    NULL AS provider_id,
    NULL AS care_site_id,
    person_source_value,
    gender_source_value,
    0 AS gender_source_concept_id,
    race_source_value,
    0 AS race_source_concept_id,
    ethnicity_source_value,
    NULL AS ethnicity_source_concept_id
FROM omop.stg__person;