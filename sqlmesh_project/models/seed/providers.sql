MODEL (
    name omop.providers,
    kind SEED (
        path "$root/seeds/csv/providers.csv"
    ),
    columns (
        Id VARCHAR(50),
        ORGANIZATION VARCHAR(50),
        NAME VARCHAR(50),
        GENDER VARCHAR(50),
        SPECIALITY VARCHAR(50),
        ADDRESS VARCHAR(50),
        CITY VARCHAR(50),
        STATE VARCHAR(50),
        ZIP BIGINT,
        LAT DECIMAL,
        LON DECIMAL,
        ENCOUNTERS BIGINT,
        PROCEDURES BIGINT
    ),
    grain (
        Id
    )
);