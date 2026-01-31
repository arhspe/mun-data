CREATE TABLE mun_info (
    mun_id        SERIAL PRIMARY KEY,
    muncod_ibge   INTEGER NOT NULL UNIQUE,
    mun_name      TEXT    NOT NULL,
    uf            CHAR(2) NOT NULL
);


CREATE TABLE mun_pop (
    pop_id        SERIAL PRIMARY KEY,
    muncod_ibge   INTEGER NOT NULL,
    pop_total     INTEGER,
    pop_branca    INTEGER,
    pop_preta     INTEGER,
    pop_amarela   INTEGER,
    pop_parda     INTEGER,
    pop_indigena  INTEGER,

    CONSTRAINT fk_mun
        FOREIGN KEY (muncod_ibge)
        REFERENCES mun_info (muncod_ibge)
        ON DELETE CASCADE
);
