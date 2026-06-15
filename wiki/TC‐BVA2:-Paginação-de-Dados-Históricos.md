**Responsável:** Victor Davidson

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** RF-07 (Visualizar histórico) / RF-09 (Exibir em ordem cronológica)

### 1. Regras e Modelagem (BVA2)

**Regra:** A API de histórico deve retornar no mínimo **1 registro** por página e no máximo **50 registros** por página. Requisições com page_size fora desse intervalo devem ser rejeitadas.

**Domínio:** 0 ≤ page_size ≤ 200.

**Partições:**

* P0 (Inválido): page_size < 1
* P1 (Válido): 1 ≤ page_size ≤ 50
* P2 (Inválido): page_size > 50

**Identificação das Bordas:**

* B1 = {0} (Tamanho zero — inválido)
* B2 = {1} (Mínimo válido — 1 registro por página)
* B3 = {50; 51} (Transição P1 → P2 — máximo de página)
* B4 = {200} (Limite máximo do domínio)

**Total de bordas identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | page_size = 0 | B1 | HTTP 400 — "O tamanho mínimo de página é 1." |
| CT2 | page_size = 1 | B2 | HTTP 200 — 1 registro retornado em ordem decrescente. |
| CT3 | page_size = 50 | B3 | HTTP 200 — Até 50 registros retornados. |
| CT4 | page_size = 51 | B3 | HTTP 400 — "O tamanho máximo de página é 50." |
| CT5 | page_size = 200 | B4 | HTTP 400 — Tamanho de página fora do limite. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas: B1 (CT1), B2 (CT2), B3 (CT3 e CT4), B4 (CT5).
* Total de bordas: 4
* **TC = 4 / 4 = 100%**
