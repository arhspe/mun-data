CREATE TABLE mun_info (
    mun_id        SERIAL PRIMARY KEY,
    muncod_ibge   INTEGER NOT NULL UNIQUE,
    mun_name      TEXT    NOT NULL,
    uf            CHAR(2) NOT NULL
);

