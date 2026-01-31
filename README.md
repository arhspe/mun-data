\# mun\_data



Análise da \*\*população residente por cor ou raça nos municípios brasileiros (Censo Demográfico 2022)\*\*, a partir da \*\*Tabela 9605 do IBGE (SIDRA)\*\*.



O projeto cobre todo o pipeline de dados: \*\*importação → tratamento → modelagem relacional → validação → análises → visualizações\*\*, com foco em boas práticas de organização, reprodutibilidade e transparência metodológica.



---



\## 📌 Fonte dos dados



\* \*\*IBGE – SIDRA\*\*

\* \*\*Tabela 9605\*\* – População residente, por cor ou raça

\* \*\*Ano:\*\* 2022 (atualização em 22/12/2023)

\* \*\*Unidade territorial:\*\* Municípios (5.570)

\* \*\*Variáveis:\*\*



&nbsp; \* Total

&nbsp; \* Branca

&nbsp; \* Preta

&nbsp; \* Amarela

&nbsp; \* Parda

&nbsp; \* Indígena



Notas metodológicas importantes do IBGE (ex.: definição de população indígena, valores inibidos, ausentes ou zerados) foram consideradas durante a validação e análises.



---



\## 🗂️ Estrutura do projeto



```text

mun\_data/

│

├── data/

│   ├── raw/              # Dados originais do IBGE (sem alterações)

│   │   └── 9605.csv

│   │

│   └── curated/          # Dados tratados e normalizados

│       ├── 9605\_mun\_info.csv

│       └── 9605\_mun\_pop.csv

│

├── docs/

│   ├── dicionario\_dados.md

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

│   └── make\_figures.py   # Geração automática dos gráficos

│

└── README.md

```



---



\## 🧱 Modelagem de dados



O banco foi modelado de forma normalizada, separando \*\*informações territoriais\*\* e \*\*dados populacionais\*\*:



\* \*\*mun\_info\*\*: código IBGE, nome do município e UF

\* \*\*mun\_pop\*\*: totais populacionais por grupo racial



A relação entre as tabelas é feita via `muncod\_ibge`.



---



\## 🔎 Validação dos dados



Foram implementadas checagens de consistência, incluindo:



\* Comparação entre `pop\_total` e a soma dos grupos raciais

\* Identificação de discrepâncias explicáveis pelas notas do IBGE

\* Criação de \*\*flag de alerta\*\* para municípios com diferenças relevantes



As validações estão documentadas em:



```text

sql/validation/selects\_validation.sql

```



---



\## 📊 Análises realizadas



\### 1️⃣ Grupo racial dominante



\* \*\*Por município\*\*

\* \*\*Por UF\*\*



SQL:



```text

sql/analyses/grupo\_racial\_dominante\_mun.sql

sql/analyses/grupo\_racial\_dominante\_uf.sql

```



📈 Exemplo de visualização:



!\[Grupo racial dominante por UF](outputs/figures/grupo\_racial\_dominante\_uf.png)



---



\### 2️⃣ Índice de diversidade racial



Mede a probabilidade de duas pessoas escolhidas aleatoriamente pertencerem a \*\*grupos raciais diferentes\*\*.



SQL:



```text

sql/analyses/diversidade\_racial.sql

```



📈 Top municípios mais diversos:



!\[Diversidade racial](outputs/figures/diversidade\_racial\_top10.png)



---



\### 3️⃣ Concentração racial



Identifica municípios onde \*\*um único grupo racial concentra grande parte da população\*\*.



SQL:



```text

sql/analyses/concentracao\_racial.sql

```



📈 Municípios com maior concentração:



!\[Concentração racial](outputs/figures/concentracao\_racial\_top10.png)



---



\## 🛠️ Tecnologias utilizadas



\* \*\*PostgreSQL\*\* – modelagem, validação e análises

\* \*\*SQL\*\* – consultas analíticas e views

\* \*\*Python (pandas + matplotlib)\*\* – geração de gráficos

\* \*\*Git/GitHub\*\* – versionamento e organização do projeto



---



\## 📎 Documentação adicional



\* 📘 \*\*Dicionário de dados:\*\* `docs/dicionario\_dados.md`

\* 📙 \*\*Metodologia e notas do IBGE:\*\* `docs/metodologia.md`



---



\## 🚀 Objetivo do projeto



Demonstrar capacidade de:



\* trabalhar com dados oficiais complexos (IBGE)

\* estruturar pipelines de dados organizados

\* aplicar validações metodológicas

\* gerar análises estatísticas e visuais

\* documentar decisões técnicas de forma clara



---



📌 \*Projeto com fins educacionais, analíticos e de portfólio.\*



