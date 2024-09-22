MODEL (
  name omop.visit_occurrence,
  kind INCREMENTAL_BY_TIME_RANGE (
    time_column visit_start_date
  ),
  grain (
    visit_occurrence_id
  ),
  columns (
    visit_occurrence_id INTEGER,
    person_id INTEGER,
    visit_concept_id INTEGER,
    visit_start_date DATE,
    visit_start_datetime TIMESTAMP,
    visit_end_date DATE,
    visit_end_datetime TIMESTAMP,
    visit_type_concept_id INTEGER,
    provider_id INTEGER,
    care_site_id INTEGER,
    visit_source_value VARCHAR(50),
    visit_source_concept_id INTEGER,
    admitted_from_concept_id INTEGER,
    admitted_from_source_value VARCHAR(50),
    discharged_to_concept_id INTEGER,
    discharged_to_source_value VARCHAR(50),
    preceding_visit_occurrence_id INTEGER
  )
);

SELECT
    visit_occurrence_id,
    person_id,
    visit_concept_id,
    visit_start_datetime::timestamp::date AS visit_start_date,
    visit_start_datetime::timestamp AS visit_start_datetime,
    visit_end_datetime::timestamp::date AS visit_end_date,
    visit_end_datetime::timestamp AS visit_end_datetime,
    0 AS visit_type_concept_id,
    provider_id,
    care_site_id,
    visit_source_value,
    NULL::int AS visit_source_concept_id,
    NULL::int AS admitted_from_concept_id,
    NULL::int AS admitted_from_source_value,
    NULL::int AS discharged_to_concept_id,
    NULL::int AS discharged_to_source_value,
    NULL::int AS preceding_visit_occurrence_id
FROM omop.int__visit_occurrence