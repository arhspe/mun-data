CREATE OR REPLACE VIEW vw_municipio_pop AS
SELECT
    i.muncod_ibge,
    i.mun_name,
    i.uf,

    p.pop_total,
    p.pop_branca,
    p.pop_preta,
    p.pop_amarela,
    p.pop_parda,
    p.pop_indigena,

    COALESCE(p.pop_branca,0)
  + COALESCE(p.pop_preta,0)
  + COALESCE(p.pop_parda,0)
  + COALESCE(p.pop_amarela,0)
  + COALESCE(p.pop_indigena,0) AS soma_racial,

    CASE
      WHEN p.pop_total IS NULL THEN NULL
      ELSE ABS(
        p.pop_total
        - (
            COALESCE(p.pop_branca,0)
          + COALESCE(p.pop_preta,0)
          + COALESCE(p.pop_parda,0)
          + COALESCE(p.pop_amarela,0)
          + COALESCE(p.pop_indigena,0)
        )
      )
    END AS diff_total_racial,

    p.flag_discrepancia

FROM mun_info i
LEFT JOIN mun_pop p USING (muncod_ibge);
