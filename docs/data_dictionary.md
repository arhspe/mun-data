# Dicionário de Dados – mun_data

Este documento descreve as tabelas, colunas e significados dos dados
utilizados na tabela core do banco `mun_data`, construído a partir de dados do
Censo Demográfico do IBGE (2022), extraídos da plataforma SIDRA.

O objetivo deste dicionário é documentar a estrutura cadastral dos municípios,
que serve como base para relacionamento com tabelas populacionais.

---

## 📚 Fonte dos dados

Instituto Brasileiro de Geografia e Estatística – IBGE  
Plataforma SIDRA – https://sidra.ibge.gov.br/tabela/9605  

Tabela utilizada para a extração de dados municipais:
- **Tabela 9605** – População residente, por cor ou raça, nos Censos Demográficos

Parâmetros principais de extração:
- Ano: 2022 (atualizado em 22/12/2023)
- Unidade territorial: Município (5.570 municípios)
- Variáveis de cor ou raça:
  - Total
  - Branca
  - Preta
  - Amarela
  - Parda
  - Indígena

**Observações**
- A Tabela 9605 também foi utilizada como fonte para a carga de outras tabelas
populacionais.

---

## 📌 Tabela: `mun_info`

Armazena informações cadastrais dos municípios.

A definição estrutural da tabela principal do banco de dados, `mun_info`, está documentada em uma query dedicada localizada em `mun-data/sql/schema/create_schema_core.sql`. Esse script é responsável pela **criação do esquema central da base**, estabelecendo os campos fundamentais de identificação territorial e servindo como ponto de partida para a reprodutibilidade de todo o banco.

| Coluna | Tipo | Descrição |
|------|------|----------|
| mun_id | SERIAL | Identificador interno do município |
| muncod_ibge | INTEGER | Código do município segundo o IBGE |
| mun_name | TEXT | Nome do município |
| uf | CHAR(2) | Unidade da Federação |

**Observações**
- O `muncod_ibge` corresponde ao código oficial do IBGE e é utilizado
  como chave lógica para relacionamento com outras tabelas.
- O campo `mun_id` possui finalidade exclusivamente técnica.
- As regras de consistência desta tabela são verificadas por meio de
queries de validação disponíveis na pasta `mun-data\sql\validation`.

---
