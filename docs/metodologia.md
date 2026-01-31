# Metodologia – Projeto mun_data

Este documento descreve as etapas metodológicas adotadas na extração,
estruturação, tratamento, validação e análise dos dados do projeto `mun_data`.

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

Os dados originais foram inicialmente armazenados na camada `raw`,
preservando sua forma original.

Após o tratamento, os dados foram normalizados em duas tabelas principais:

- `mun_info`: dados cadastrais e administrativos dos municípios
- `mun_pop`: dados populacionais por cor ou raça

Essa separação visa:
- reduzir redundância
- facilitar manutenção
- melhorar integridade relacional
- permitir análises escaláveis

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

Essa decisão preserva a fidelidade metodológica e evita inferências indevidas.

---

## 4. Validação e consistência

Foram realizadas verificações de consistência entre:
- população total (`pop_total`)
- soma das populações por cor ou raça

Diferenças foram esperadas e aceitas, conforme as notas metodológicas do IBGE,
especialmente devido às definições específicas da população indígena.

Para fins de transparência analítica, foi criada a flag:
- `flag_discrepancia`, indicando divergências acima de um limite definido.

---

## 5. Análises

As análises foram realizadas exclusivamente por meio de consultas SQL,
organizadas na camada `analyses`.

Entre os principais indicadores produzidos:
- Grupo racial dominante por município e por UF
- Índice de diversidade racial (Índice de Simpson)
- Rankings populacionais
- Identificação de municípios com alta concentração racial
- Diagnóstico de qualidade e consistência dos dados

No cálculo do índice de diversidade, valores `NULL` foram tratados como zero
apenas no nível analítico, sem alteração dos dados armazenados.

---

## 6. Considerações finais

Este projeto prioriza:
- reprodutibilidade
- transparência metodológica
- aderência às definições oficiais do IBGE

As decisões técnicas adotadas equilibram rigor estatístico,
clareza analítica e boas práticas de engenharia de dados.
