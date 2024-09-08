MODEL (
    name omop.organizations,
    kind SEED (
        path "$root/seeds/csv/organizations.csv"
    ),
    columns (
        Id VARCHAR(255),
        NAME VARCHAR(255),
        ADDRESS VARCHAR(255),
        CITY VARCHAR(255),
        STATE VARCHAR(255),
        ZIP BIGINT,
        LAT DOUBLE,
        LON DOUBLE,
        PHONE VARCHAR(255),
        REVENUE BIGINT,
        UTILIZATION BIGINT
    ),
    grain (
        Id
    )
);