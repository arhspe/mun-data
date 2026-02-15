SELECT 
  muncod_ibge,
  COUNT(*) AS qtd
FROM mun_info
GROUP BY muncod_ibge
HAVING COUNT(*) > 1;