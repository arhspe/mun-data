SELECT
  mun_name,
  uf,
  COUNT(*) AS qtd
FROM mun_info
GROUP BY mun_name, uf
HAVING COUNT(*) > 1;
