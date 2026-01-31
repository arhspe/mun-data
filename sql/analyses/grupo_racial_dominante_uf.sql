SELECT
    uf,
    CASE
      WHEN SUM(pop_branca)   = GREATEST(
           SUM(pop_branca),
           SUM(pop_preta),
           SUM(pop_parda),
           SUM(pop_amarela),
           SUM(pop_indigena)
      ) THEN 'Branca'
      WHEN SUM(pop_preta)    = GREATEST(
           SUM(pop_branca),
           SUM(pop_preta),
           SUM(pop_parda),
           SUM(pop_amarela),
           SUM(pop_indigena)
      ) THEN 'Preta'
      WHEN SUM(pop_parda)    = GREATEST(
           SUM(pop_branca),
           SUM(pop_preta),
           SUM(pop_parda),
           SUM(pop_amarela),
           SUM(pop_indigena)
      ) THEN 'Parda'
      ELSE 'Indígena'
    END AS grupo_dominante
FROM vw_municipio_pop
GROUP BY uf
ORDER BY uf;
