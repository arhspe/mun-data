SELECT COUNT(*) AS total_municipios
FROM mun_info;


SELECT COUNT(*) AS total_registros_pop
FROM mun_pop;


SELECT mi.mun_id, mi.mun_name, mi.uf
FROM mun_info mi
LEFT JOIN mun_pop mp ON mp.mun_id = mi.mun_id
WHERE mp.mun_id IS NULL;
