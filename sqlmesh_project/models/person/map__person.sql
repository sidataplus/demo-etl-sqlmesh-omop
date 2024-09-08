MODEL (
  name omop.map__person,
  kind INCREMENTAL_BY_UNIQUE_KEY (
    unique_key Id
  ),
  grain (
    person_id
  ),
  columns (
    person_id INTEGER,
    Id VARCHAR(255)
  ),
  audits (UNIQUE_VALUES(columns = (
    person_id
  )), UNIQUE_VALUES(columns = (
    Id
  )))
);

SELECT
  @map_running_id(Id) AS person_id,
  Id
FROM omop.patients;