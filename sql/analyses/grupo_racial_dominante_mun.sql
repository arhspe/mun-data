SELECT
    mun_name,
    uf,
    CASE
      WHEN pop_branca   = GREATEST(pop_branca, pop_preta, pop_parda, pop_amarela, pop_indigena) THEN 'Branca'
      WHEN pop_preta    = GREATEST(pop_branca, pop_preta, pop_parda, pop_amarela, pop_indigena) THEN 'Preta'
      WHEN pop_parda    = GREATEST(pop_branca, pop_preta, pop_parda, pop_amarela, pop_indigena) THEN 'Parda'
      WHEN pop_indigena = GREATEST(pop_branca, pop_preta, pop_parda, pop_amarela, pop_indigena) THEN 'Indígena'
      ELSE 'Amarela'
    END AS grupo_dominante,
    pop_total
FROM vw_municipio_pop
ORDER BY uf, mun_name;
