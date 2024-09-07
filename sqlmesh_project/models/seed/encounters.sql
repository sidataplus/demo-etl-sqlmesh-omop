MODEL (
    name omop.encounters,
    kind SEED (
        path "$root/seeds/csv/encounters.csv"
    ),
    columns (
        Id VARCHAR(255),
        START VARCHAR(255),
        STOP VARCHAR(255),
        PATIENT VARCHAR(255),
        ORGANIZATION VARCHAR(255),
        PROVIDER VARCHAR(255),
        PAYER VARCHAR(255),
        ENCOUNTERCLASS VARCHAR(255),
        CODE BIGINT,
        DESCRIPTION VARCHAR(255),
        BASE_ENCOUNTER_COST DECIMAL,
        TOTAL_CLAIM_COST DECIMAL,
        PAYER_COVERAGE DECIMAL,
        REASONCODE BIGINT,
        REASONDESCRIPTION VARCHAR(255)
    ),
    grain (
        Id
    )
);