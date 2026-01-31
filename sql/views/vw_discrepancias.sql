CREATE OR REPLACE VIEW vw_discrepancias AS
SELECT
    mun_name,
    uf,
    pop_total,
    soma_racial,
    diff_total_racial
FROM vw_municipio_pop
WHERE flag_discrepancia = TRUE
ORDER BY diff_total_racial DESC;
