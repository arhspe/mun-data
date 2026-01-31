import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

OUTPUT_DIR = Path("outputs/figures")
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

df_div = pd.read_csv("outputs/diversidade_racial.csv")

top10_div = (
    df_div
    .sort_values("indice_diversidade", ascending=False)
    .head(10)
)

plt.figure()
plt.barh(top10_div["mun_name"], top10_div["indice_diversidade"])
plt.xlabel("Índice de Diversidade Racial")
plt.ylabel("Município")
plt.title("Top 10 Municípios com Maior Diversidade Racial")
plt.gca().invert_yaxis()
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "diversidade_top10.png", dpi=150)
plt.close()

df_div_uf = (
    df_div
    .groupby("uf", as_index=False)["indice_diversidade"]
    .mean()
    .sort_values("indice_diversidade", ascending=False)
)

plt.figure()
plt.bar(df_div_uf["uf"], df_div_uf["indice_diversidade"])
plt.xlabel("UF")
plt.ylabel("Índice médio de diversidade")
plt.title("Diversidade Racial Média por UF")
plt.xticks(rotation=90)
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "diversidade_media_uf.png", dpi=150)
plt.close()

df_dom_uf = pd.read_csv("outputs/grupo_racial_dominante_uf.csv")

counts_dom = df_dom_uf["grupo_dominante"].value_counts()

plt.figure()
counts_dom.plot(kind="bar")
plt.xlabel("Grupo racial dominante")
plt.ylabel("Número de UFs")
plt.title("Grupo Racial Dominante por UF")
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "grupo_dominante_uf.png", dpi=150)
plt.close()


df_conc = pd.read_csv("outputs/concentracao_racial.csv")

top10_conc = (
    df_conc
    .sort_values("concentracao_maxima", ascending=False)
    .head(10)
)

plt.figure()
plt.barh(top10_conc["mun_name"], top10_conc["concentracao_maxima"])
plt.xlabel("Proporção do grupo racial dominante")
plt.ylabel("Município")
plt.title("Municípios com Maior Concentração Racial")
plt.gca().invert_yaxis()
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "concentracao_racial_top10.png", dpi=150)
plt.close()

print("Gráficos gerados com sucesso em outputs/figures/")
