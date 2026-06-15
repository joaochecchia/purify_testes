**Responsável:** João Gabriel Brito Checchia

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-08 (Filtrar histórico por região)

### 1. Regras e Modelagem (EP)

**Variável analisada:** Parâmetros de filtro de histórico fornecidos pelo usuário

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Região com dados no período | Região selecionada tem registros no período solicitado | Lista de dados históricos retornada em ordem cronológica decrescente |
| P2 | Região sem dados no período | Região selecionada não tem registros no período | Mensagem: "Não há dados para esta região no período selecionado." |
| P3 | Região não existente | ID de região inválido ou inexistente | HTTP 404 — "Região não encontrada." |
| P4 | Filtro sem região | Requisição sem parâmetro de região | HTTP 400 — "Selecione uma região para consultar o histórico." |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | região="Taguatinga"; período=30 dias | P1 | HTTP 200 — Lista de dados históricos em ordem decrescente. |
| CT2 | região="Planaltina"; período=7 dias (sem dados) | P2 | HTTP 200 — "Não há dados para esta região no período selecionado." |
| CT3 | região_id=99999 (não existe) | P3 | HTTP 404 — "Região não encontrada." |
| CT4 | Sem parâmetro de região na query | P4 | HTTP 400 — "Selecione uma região para consultar o histórico." |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4).
* Total de partições: 4
* **TC = 4 / 4 = 100%**
