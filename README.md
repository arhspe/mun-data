# Banco de Dados mun_data

Análise da **população residente por cor ou raça nos municípios brasileiros (Censo Demográfico 2022)**, a partir da **Tabela 9605 do IBGE (SIDRA)**.  

O projeto cobre todo o pipeline de dados — da importação à visualização — com foco em boas práticas de organização, reprodutibilidade e transparência metodológica.

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

> Notas metodológicas importantes do IBGE (ex.: definição de população indígena, valores inibidos, ausentes ou zerados) foram consideradas durante a validação e análises.

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

A relação entre as tabelas é feita via `muncod_ibge`.

---

## 🔎 Validação dos dados

Foram implementadas checagens de consistência, incluindo:

- Comparação entre `pop_total` e a soma dos grupos raciais
- Identificação de discrepâncias explicáveis pelas notas do IBGE
- Criação de **flag de alerta** para municípios com diferenças relevantes

As validações estão documentadas em:

```text
sql/validation/selects_validation.sql
```
---

## 📊 Análises realizadas
> *As visualizações foram geradas em Python (pandas + matplotlib) a partir das consultas SQL.*

### 1️. Grupo racial dominante

- **Por município**
- **Por UF**

SQL:

```text
sql/analyses/grupo_racial_dominante_mun.sql
sql/analyses/grupo_racial_dominante_uf.sql
```

📈 Exemplo de visualização:

<p align="center">
  <img src="outputs/figures/grupo_dominante_uf.png" width="55%">
</p>

---

### 2️. Índice de diversidade racial

SQL:

```text
sql/analyses/diversidade_racial.sql
```
📈 Exemplo de visualização:

<p align="center">
  <img src="outputs/figures/diversidade_media_uf.png" width="55%">
</p>

<p align="center">
  <img src="outputs/figures/diversidade_top10.png" width="55%">
</p>

---

### 3. Concentração racial

SQL:

```text
sql/analyses/concentracao_racial.sql
```
📈 Exemplo de visualização:

<p align="center">
  <img src="outputs/figures/concentracao_racial_top10.png" width="55%">
</p>

---

### 🗺️ Análise final e principais insights regionais

As análises do Censo Demográfico 2022 (IBGE – Tabela 9605) evidenciam diferenças marcantes na composição racial entre as regiões do Brasil: 

#### **🌴 Norte e Nordeste** 

Apresentam, em média, **maior diversidade racial**, com menor concentração em um único grupo e maior equilíbrio entre as categorias raciais em diversos municípios. Essas regiões concentram muitos dos municípios com **índices elevados de diversidade**. 

#### **🏙️ Sudeste** 

Exibe um perfil **heterogêneo**, combinando municípios altamente diversos — sobretudo em áreas urbanas — com outros de **alta concentração racial**, especialmente fora dos grandes centros. 

**🌾 Centro-Oeste** 

Mostra **padrões intermediários**, com diversidade moderada e variações relevantes entre municípios, influenciadas por **processos recentes de ocupação e migração interna**. 

#### **❄️ Sul** 

Destaca-se pela **menor diversidade média** e por **elevados níveis de concentração racial**, refletindo um padrão mais homogêneo em grande parte dos municípios da região. 

### 🧭 Síntese 

Em conjunto, os dados revelam um país marcado por fortes contrastes regionais, reforçando a importância da análise em escala municipal para compreender a complexidade demográfica brasileira. As análises são descritivas, seguem as notas metodológicas do IBGE e foram validadas para garantir consistência e reprodutibilidade.

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
