SELECT
    mun_name,
    uf,
    GREATEST(
        pop_branca,
        pop_preta,
        pop_parda,
        pop_amarela,
        pop_indigena
    )::NUMERIC / pop_total AS concentracao_maxima
FROM vw_municipio_pop
WHERE pop_total > 0
ORDER BY concentracao_maxima DESC;
