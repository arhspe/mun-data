# Banco de Dados mun_data
![Coverage](https://img.shields.io/badge/Coverage-National%20(5.570%20mun)-3b82f6?logo=map&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-3b82f6)
<br>
![DB Engine](https://img.shields.io/badge/DBMS-PostgreSQL-3b82f6?logo=postgresql&logoColor=white)
![Primary Key](https://img.shields.io/badge/Primary%20Key-IBGE%20Code-3b82f6?logo=key&logoColor=white)
![Data Source](https://img.shields.io/badge/Data%20Source-IBGE%20SIDRA-3b82f6?logo=databricks&logoColor=white)

O `mun_data` é um **banco de dados relacional** desenvolvido para fornecer uma **base cadastral consistente de municípios brasileiros**, a partir dos dados oficiais do Censo Demográfico 2022 do IBGE.

Este repositório concentra-se exclusivamente na estrutura do banco e nos processos de importação e validação, servindo como fundação para análises demográficas e projetos analíticos derivados.

> 📊 As análises, tabelas populacionais e visualizações baseadas neste banco estão disponíveis no repositório complementar `mun-data-tables`.
---

## 📌 Fonte dos dados

- **IBGE – SIDRA**
- **Ano:** 2022 (atualização em 22/12/2023)
- **Unidade territorial:** Municípios (5.570)
- **Cobertura:** nacional completa

As notas metodológicas oficiais do IBGE foram consideradas durante o processo de importação e validação, especialmente no que se refere a valores ausentes, inibidos e definições específicas de população.  

---

## 🧱 Escopo do banco de dados

O escopo deste repositório é deliberadamente restrito à camada estrutural do banco de dados, contemplando:

- definição do schema
- criação da tabela `mun_info`
- importação dos dados cadastrais
- validação de consistência e integridade

Análises estatísticas, métricas derivadas e interpretações analíticas não fazem parte deste repositório.

---

## 🗂️ Estrutura do projeto

```text
mun_data/
│
├── data/
│   ├── raw/              # Dados originais do IBGE (sem alterações)
│   │   └── 9605.csv
│   └── curated/          # Dados tratados para carga da tabela core
│       └── 9605mun_info.csv
│
├── docs/
│   ├── data_dictionary.md
│   └── methodology.md
│
├── sql/
│   ├── schema/           # Criação do schema e tabelas
│   ├── import/           # Importação dos dados
│   └── validation/       # Validações de consistência
│
├── LICENSE.md
└── README.md
```
---

## 🧱 Tabela principal do Banco: `mun_info` 

A tabela `mun_info` armazena informações cadastrais e estruturais dos municípios e atua como **dimensão principal do banco de dados**.

Ela é independente de qualquer variável estatística específica e foi projetada para servir como base de relacionamento para tabelas populacionais e analíticas em outros repositórios.

### Campos principais ###

- Código oficial do município (IBGE)
- Nome do município
- Unidade da Federação (UF)

O código IBGE `(muncod_ibge)` é utilizado como chave lógica natural, garantindo compatibilidade com bases oficiais e expansões futuras.

---

## 🔎 Validação dos dados

Foram implementadas queries de validação específicas para a tabela `mun_info`, com foco em garantir a qualidade da base cadastral municipal, incluindo:

- contagem esperada de municípios
- unicidade do código IBGE
- verificação de campos nulos ou vazios
- validação de formatos básicos (UF e código IBGE)

---

## 🛠️ Tecnologias utilizadas

- **PostgreSQL** – modelagem, validação e análises
- **SQL** – consultas analíticas e views
- **Git/GitHub** – versionamento e organização do projeto

---

## 📎 Documentação adicional

- **Dicionário de dados:** `docs/data_dictionary.md`
- **Metodologia:** `docs/methodology.md`

---

## 🔗 Repositório complementar

Para consultas analíticas, tabelas populacionais derivadas e visualizações: `mun-data-tables`.