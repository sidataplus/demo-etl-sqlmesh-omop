MODEL (
    name omop.conditions,
    kind SEED (
        path "$root/seeds/csv/conditions.csv"
    ),
    columns (
        START VARCHAR(255),
        STOP VARCHAR(255),
        PATIENT VARCHAR(255),
        ENCOUNTER VARCHAR(255),
        SYSTEM VARCHAR(255),
        CODE BIGINT,
        DESCRIPTION VARCHAR(255)
    ),
    grain (
        START
    )
);