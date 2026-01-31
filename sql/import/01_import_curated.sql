\copy mun_info (muncod_ibge, mun_name, uf)
FROM 'C:/Users/arthu/Desktop/mun_data/data/curated/9605mun_info.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

\copy mun_pop (muncod_ibge, pop_total, pop_branca, pop_preta, pop_amarela, pop_parda, pop_indigena)
FROM 'C:/Users/arthu/Desktop/mun_data/data/curated/9605mun_pop.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

