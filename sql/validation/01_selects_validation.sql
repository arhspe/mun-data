-- 1 chaves orfas
SELECT p.muncod_ibge
FROM mun_pop p
LEFT JOIN mun_info i USING (muncod_ibge)
WHERE i.muncod_ibge IS NULL;

-- 2 duplicidade
SELECT muncod_ibge, COUNT(*)
FROM mun_pop
GROUP BY muncod_ibge
HAVING COUNT(*) > 1;

-- 3 discrepancia total vs soma racial
SELECT
  i.mun_name,
  i.uf,
  p.pop_total,
  COALESCE(p.pop_branca,0)
+ COALESCE(p.pop_preta,0)
+ COALESCE(p.pop_parda,0)
+ COALESCE(p.pop_amarela,0)
+ COALESCE(p.pop_indigena,0) AS soma_racial
FROM mun_pop p
JOIN mun_info i USING (muncod_ibge)
WHERE p.pop_total IS NOT NULL
AND p.pop_total <>
    COALESCE(p.pop_branca,0)
  + COALESCE(p.pop_preta,0)
  + COALESCE(p.pop_parda,0)
  + COALESCE(p.pop_amarela,0)
  + COALESCE(p.pop_indigena,0);
