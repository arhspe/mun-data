# Banco de Dados mun_data
![GitHub last commit](https://img.shields.io/github/last-commit/arhspe/mun-data)
![Status](https://img.shields.io/badge/status-completo-brightgreen)
![License](https://img.shields.io/github/license/arhspe/mun-data)
<br>
![Database](https://img.shields.io/badge/Database-PostgreSQL-blue)
![Pipeline](https://img.shields.io/badge/Pipeline-ETL%2FELT-blueviolet)
![Data Source](https://img.shields.io/badge/Data%20Source-IBGE%20SIDRA-0a66c2)

Banco de dados analítico desenvolvido para investigar a **composição racial da população residente nos municípios brasileiros**, com base no **Censo Demográfico de 2022** e na **Tabela 9605 do IBGE (SIDRA)**.

O projeto implementa um pipeline completo de dados — da ingestão à análise — com foco em **modelagem relacional**, **validação metodológica**, **reprodutibilidade** e **transparência analítica**.

---

## 📌 Fonte dos dados

- **IBGE – SIDRA**
- **Tabela 9605** – População residente, por cor ou raça
- **Ano:** 2022 (atualização em 22/12/2023)
- **Unidade territorial:** Municípios (5.570)
- **Variáveis:**
  - Total
  - Branca
  - Preta
  - Amarela
  - Parda
  - Indígena
  
#### Considerações metodológicas

Durante o processo de validação e análise foram consideradas as notas técnicas oficiais do IBGE, incluindo:

- critérios de autodeclaração racial
- definições específicas de população indígena
- presença de valores inibidos, ausentes ou zerados

> _Notas metodológicas importantes do IBGE (ex.: definição de população indígena, valores inibidos, ausentes ou zerados) foram consideradas durante a validação e análises._

---

## 🗂️ Estrutura do projeto

```text
mun_data/
│
├── data/
│   ├── raw/              # Dados originais do IBGE (sem alterações)
│   │   └── 9605.csv
│   └── curated/          # Dados tratados e normalizados
│       ├── 9605mun_info.csv
│       └── 9605mun_pop.csv
│
├── docs/
│   ├── dicionario_dados.md
│   └── metodologia.md
│
├── sql/
│   ├── schema/           # Criação e alteração do banco
│   ├── import/           # Importação dos CSVs
│   ├── validation/       # Checagens de consistência
│   ├── views/            # Views analíticas
│   └── analyses/         # Consultas analíticas finais
│
├── outputs/
│   ├── tables/           # Resultados em CSV
│   └── figures/          # Gráficos usados no README
│
├── scripts/
│   └── make_figures.py   # Geração automática dos gráficos
│
└── README.md
```
---

## 🧱 Modelagem de dados

O banco foi modelado de forma **normalizada**, separando **informações territoriais** e **dados populacionais**:

- **mun_info:** código IBGE, nome do município e UF
- **mun_pop:** totais populacionais por grupo racial

A relação entre as tabelas é feita via `muncod_ibge`

---

## 🔎 Validação dos dados

Foram implementadas checagens de consistência, incluindo:

- Comparação entre `pop_total` e a soma dos grupos raciais
- Identificação de discrepâncias explicáveis pelas notas do IBGE
- Criação de **flag de alerta** para municípios com diferenças relevantes

As validações estão documentadas em `sql/validation/selects_validation.sql`

---

## 📊 Análises realizadas

As análises apresentadas a seguir têm caráter demonstrativo e exploratório, com o objetivo de evidenciar o potencial analítico da base estruturada.

A modelagem relacional e as validações implementadas permitem a construção de diversas outras abordagens analíticas — como estudos temporais (em expansões futuras), análises comparativas regionais, correlações socioeconômicas e indicadores compostos.

Como exemplos iniciais, foram desenvolvidas análises que destacam padrões de distribuição racial, níveis de diversidade e graus de concentração populacional, por apresentarem forte capacidade de revelar contrastes territoriais no contexto demográfico brasileiro.

> *As visualizações foram geradas em Python (pandas + matplotlib) a partir das consultas SQL.*

### 1️. Grupo racial dominante

- **Por UF**

SQL:

`sql/analyses/grupo_racial_dominante_mun.sql` e `sql/analyses/grupo_racial_dominante_uf.sql`

<p align="center">
  <img src="outputs/figures/grupo_dominante_uf.png" width="55%">
</p>

---

### 2️. Índice de diversidade racial

- **Por município**
- **Por UF**
  
SQL:

`sql/analyses/diversidade_racial.sql`

<p align="center">
  <img src="outputs/figures/diversidade_media_uf.png" width="55%">
</p>

<p align="center">
  <img src="outputs/figures/diversidade_top10.png" width="55%">
</p>

---

### 3. Concentração racial

- **Por município**

SQL:

`sql/analyses/concentracao_racial.sql`

<p align="center">
  <img src="outputs/figures/concentracao_racial_top10.png" width="55%">
</p>

---

## 🗺️ Análise final e principais insights regionais

A síntese a seguir apresenta interpretações descritivas baseadas nos indicadores analíticos construídos a partir da Tabela 9605 do Censo Demográfico 2022 (IBGE), especialmente métricas de **diversidade racial**, **concentração populacional** e **grupo racial predominante** em escala municipal.

### 🟢 Norte e Nordeste

Os indicadores de diversidade racial apontam, em média, maior heterogeneidade populacional nessas regiões, com menor predominância de um único grupo racial em diversos municípios. Observa-se maior frequência de municípios com índices elevados de diversidade quando comparados ao restante do país.

### 🟡 Sudeste

Apresenta elevada variabilidade interna. Municípios de grande porte tendem a demonstrar maior diversidade racial, enquanto áreas fora dos principais centros urbanos evidenciam padrões mais concentrados, sugerindo heterogeneidade regional significativa.

### 🟠 Centro-Oeste

Os resultados indicam padrões intermediários de diversidade e concentração racial. Observa-se variação relevante entre municípios, possivelmente associada a dinâmicas recentes de ocupação territorial e fluxos migratórios internos.

### 🔵 Sul

Os indicadores apontam menor diversidade média e maior concentração populacional em grupos raciais específicos em comparação com outras regiões, indicando maior homogeneidade demográfica relativa em parte dos municípios analisados.

### Síntese geral

Os indicadores construídos evidenciam diferenças regionais consistentes na composição racial municipal. A análise reforça a importância de abordagens em escala local para compreensão da diversidade demográfica brasileira.

As interpretações apresentadas possuem caráter descritivo, seguem as notas metodológicas oficiais do IBGE e baseiam-se em dados previamente validados para garantir consistência analítica e reprodutibilidade.


---

## 🛠️ Tecnologias utilizadas

- **PostgreSQL** – modelagem, validação e análises
- **SQL** – consultas analíticas e views
- **Python (pandas + matplotlib)** – geração de gráficos
- **Git/GitHub** – versionamento e organização do projeto

---

## 📎 Documentação adicional

- **Dicionário de dados:** `docs/dicionario_dados.md`
- **Metodologia e notas do IBGE:** `docs/metodologia.md`
