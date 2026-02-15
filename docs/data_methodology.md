# Metodologia – Banco mun_data

Este documento descreve as etapas metodológicas adotadas na extração,
estruturação, tratamento, validação e organização dos dados utilizados
no projeto `mun_data`.

---

## 1 Fonte e extração dos dados

Os dados utilizados neste projeto foram extraídos da plataforma
**SIDRA/IBGE**, utilizando a Tabela 9605, referente ao
Censo Demográfico.

### Tabela selecionada
- **Tabela 9605** – População residente, por cor ou raça, nos Censos Demográficos

---

## 1.1 Parâmetros de extração no SIDRA

A extração foi realizada com os seguintes parâmetros:

### Variável principal
- População residente (Pessoas)

### Cor ou raça
- Total
- Branca
- Preta
- Amarela
- Parda
- Indígena

### Ano
- 2022 (dados atualizados em 22/12/2023)

### Unidade territorial
- Município  
  - Total de municípios: 5.570  
  - Cobertura nacional completa

Outros níveis territoriais (Brasil, Grandes Regiões, Unidades da Federação,
Regiões Geográficas Intermediárias e Imediatas, Concentrações Urbanas)
não foram selecionados, a fim de evitar duplicidade de registros e
preservar a maior granularidade possível.

### Configurações adicionais
- Formato do arquivo: CSV (padrão Brasil)
- Ranking de valores: não aplicado
- Exibição ativada:
  - códigos de territórios
  - nomes de territórios
  - siglas de níveis territoriais

---

## 2. Estruturação dos dados

Os dados extraídos foram inicialmente armazenados na camada `raw`,
preservando integralmente a estrutura, os valores e o conteúdo original
fornecido pelo IBGE.

Essa camada tem como finalidade:

- garantir rastreabilidade da fonte

- permitir auditoria do processo de tratamento

- evitar perda de informação original

Após o tratamento inicial, os dados foram organizados em tabelas
normalizadas, com destaque para:

`mun_info`: tabela core, contendo dados cadastrais e estruturais
dos municípios, independentes da variável estatística analisada

Essa separação estrutural visa:

reduzir redundância

facilitar manutenção

melhorar integridade relacional

permitir expansões futuras com novas tabelas populacionais ou temáticas
---

## 3. Tratamento de valores especiais

Conforme a legenda oficial do IBGE, os seguintes símbolos foram tratados:

| Símbolo | Tratamento adotado |
|------|------------------|
| `-` | Importado como `NULL` |
| `X` | Importado como `NULL` (valor inibido) |
| `..` | Importado como `NULL` |
| `...` | Importado como `NULL` |
| `0` | Mantido como zero numérico |

---


## Validação e controle de qualidade dos dados

Após a carga dos dados, foram executadas queries de validação
para verificação da consistência da tabela mun_info, incluindo:

- contagem esperada de municípios

- unicidade do código IBGE

- - verificação de campos nulos ou vazios

validação de formatos básicos (UF e código IBGE)

Essas validações foram implementadas como consultas SQL,
permitindo transparência e reprodutibilidade dos resultados.