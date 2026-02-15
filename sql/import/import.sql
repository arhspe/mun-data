\copy mun_info (muncod_ibge, mun_name, uf)
FROM 'C:/Users/arthu/Desktop/mun_data/data/curated/9605mun_info.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';


