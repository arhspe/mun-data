# Dicionário de Dados – mun_data

Este documento descreve as tabelas, colunas e significados dos dados
utilizados no banco `mun_data`, construído a partir de dados do
Censo Demográfico do IBGE (2022), extraídos da plataforma SIDRA.

---

## 📚 Fonte dos dados

Instituto Brasileiro de Geografia e Estatística – IBGE  
Plataforma SIDRA – https://sidra.ibge.gov.br/tabela/9605  

Tabela utilizada:
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

---

## 📌 Tabela: `mun_info`

Armazena informações cadastrais dos municípios.

| Coluna | Tipo | Descrição |
|------|------|----------|
| mun_id | SERIAL | Identificador interno do município |
| muncod_ibge | INTEGER | Código do município segundo o IBGE |
| mun_name | TEXT | Nome do município |
| uf | CHAR(2) | Unidade da Federação |

**Observações**
- O `muncod_ibge` corresponde ao código oficial do IBGE e é utilizado
  como chave lógica para relacionamento com a tabela `mun_pop`.
- O campo `mun_id` possui finalidade exclusivamente técnica.

---

## 📌 Tabela: `mun_pop`

Armazena dados populacionais por município, segundo cor ou raça.

| Coluna | Tipo | Descrição |
|------|------|----------|
| pop_id | SERIAL | Identificador interno do registro |
| muncod_ibge | INTEGER | Código do município (IBGE) |
| pop_total | INTEGER | População residente total |
| pop_branca | INTEGER | População de cor ou raça branca |
| pop_preta | INTEGER | População de cor ou raça preta |
| pop_amarela | INTEGER | População de cor ou raça amarela |
| pop_parda | INTEGER | População de cor ou raça parda |
| pop_indigena | INTEGER | População indígena |
| flag_discrepancia| BOOLEAN  | Indica divergência entre `pop_total` e a soma das populações por cor ou raça |

**Observações**
- Valores especiais da legenda do IBGE (`-`, `X`, `..`, `...`) foram
  importados como `NULL`.
- `muncod_ibge` referencia `mun_info(muncod_ibge)`.
- A coluna `flag_discrepancia` é utilizada para controle de qualidade dos dados,
  sinalizando inconsistências entre o total informado e a soma das categorias.
- A soma das populações por cor ou raça pode diferir da população total,
  conforme as definições metodológicas do IBGE, especialmente nos casos
  relacionados à população indígena.

---

## 📌 View: `vw_municipio_pop`

View analítica que consolida `mun_info` e `mun_pop`, incorporando
campos derivados para validação e análise.

Campos adicionais:
- `soma_racial`: soma das populações por cor ou raça
- `diff_total_racial`: diferença absoluta entre `pop_total` e `soma_racial`
- `flag_discrepancia`: indicador de divergência relevante
