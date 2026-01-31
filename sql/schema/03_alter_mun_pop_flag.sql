ALTER TABLE mun_pop
ADD COLUMN IF NOT EXISTS flag_discrepancia BOOLEAN;

UPDATE mun_pop
SET flag_discrepancia = (
    pop_total IS NOT NULL
    AND ABS(
        pop_total
        - (
            COALESCE(pop_branca,0)
          + COALESCE(pop_preta,0)
          + COALESCE(pop_parda,0)
          + COALESCE(pop_amarela,0)
          + COALESCE(pop_indigena,0)
        )
    ) > 100
);
