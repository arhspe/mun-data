SELECT
    mun_name,
    uf,
    1 - (
        POWER(COALESCE(pop_branca, 0)::NUMERIC   / pop_total, 2) +
        POWER(COALESCE(pop_preta, 0)::NUMERIC    / pop_total, 2) +
        POWER(COALESCE(pop_parda, 0)::NUMERIC    / pop_total, 2) +
        POWER(COALESCE(pop_amarela, 0)::NUMERIC  / pop_total, 2) +
        POWER(COALESCE(pop_indigena, 0)::NUMERIC / pop_total, 2)
    ) AS indice_diversidade
FROM vw_municipio_pop
WHERE pop_total > 0
ORDER BY indice_diversidade DESC;
