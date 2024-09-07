MODEL (
    name omop.patients,
    kind SEED (
        path "$root/seeds/csv/patients.csv"
    ),
    columns (
        Id VARCHAR(255),
        BIRTHDATE VARCHAR(255),
        DEATHDATE VARCHAR(255),
        SSN VARCHAR(255),
        DRIVERS VARCHAR(255),
        PASSPORT VARCHAR(255),
        PREFIX VARCHAR(255),
        FIRST VARCHAR(255),
        MIDDLE VARCHAR(255),
        LAST VARCHAR(255),
        SUFFIX VARCHAR(255),
        MAIDEN VARCHAR(255),
        MARITAL VARCHAR(255),
        RACE VARCHAR(255),
        ETHNICITY VARCHAR(255),
        GENDER VARCHAR(255),
        BIRTHPLACE VARCHAR(255),
        ADDRESS VARCHAR(255),
        CITY VARCHAR(255),
        STATE VARCHAR(255),
        COUNTY VARCHAR(255),
        FIPS BIGINT,
        ZIP BIGINT,
        LAT DECIMAL,
        LON DECIMAL,
        HEALTHCARE_EXPENSES DECIMAL,
        HEALTHCARE_COVERAGE DECIMAL,
        INCOME BIGINT
    ),
    grain (
        Id
    )
);