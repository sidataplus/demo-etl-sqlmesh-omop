MODEL (
  name omop.int__visit_occurrence,
  kind VIEW,
  grain (
    visit_occurrence_id
  )
);

-- Combine staging data with 'Person', 'Provider' and 'Care_site' tables
WITH final AS (
    SELECT
        stg__vo.visit_occurrence_id AS visit_occurrence_id,
        p.person_id AS person_id,
        stg__vo.visit_concept_id AS visit_concept_id,
        stg__vo.visit_start_datetime AS visit_start_datetime,
        stg__vo.visit_end_datetime AS visit_end_datetime,
        pr.provider_id AS provider_id,
        cs.care_site_id AS care_site_id,
        stg__vo.visit_source_value AS visit_source_value
    FROM omop.stg__visit_occurrence AS stg__vo
    JOIN omop.person AS p
        ON stg__vo.PATIENT = p.person_source_value
    JOIN omop.provider AS pr
        ON stg__vo.PROVIDER = pr.provider_source_value
    JOIN omop.care_site AS cs
        ON stg__vo.ORGANIZATION = cs.care_site_source_value
)

SELECT
    visit_occurrence_id,
    person_id,
    visit_concept_id,
    visit_start_datetime,
    visit_end_datetime,
    provider_id,
    care_site_id,
    visit_source_value
FROM final;