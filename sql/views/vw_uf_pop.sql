CREATE OR REPLACE VIEW vw_uf_pop AS
SELECT
    uf,

    SUM(pop_total)    AS pop_total,
    SUM(pop_branca)   AS pop_branca,
    SUM(pop_preta)    AS pop_preta,
    SUM(pop_parda)    AS pop_parda,
    SUM(pop_amarela)  AS pop_amarela,
    SUM(pop_indigena) AS pop_indigena,

    SUM(soma_racial)  AS soma_racial,

    ABS(
        SUM(pop_total)
        - SUM(soma_racial)
    ) AS diff_total_racial

FROM vw_municipio_pop
GROUP BY uf;
