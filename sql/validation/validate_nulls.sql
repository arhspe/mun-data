SELECT *
FROM mun_info
WHERE mun_name IS NULL
   OR TRIM(mun_name) = '';

SELECT *
FROM mun_info
WHERE uf IS NULL;
