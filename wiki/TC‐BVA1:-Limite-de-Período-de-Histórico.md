**Responsável:** Victor Davidson

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** RF-09 (Exibir histórico em ordem cronológica) / RN-005 / F17

### 1. Regras e Modelagem (BVA2)

**Regra:** O filtro de período do histórico deve aceitar no mínimo **1 dia** e no máximo **365 dias** (1 ano). Períodos fora dessa faixa devem ser rejeitados.

**Domínio:** 0 ≤ período (dias) ≤ 730.

**Partições:**

* P0 (Inválido): período < 1
* P1 (Válido): 1 ≤ período ≤ 365
* P2 (Inválido): período > 365

**Identificação das Bordas:**

* B1 = {0} (Período zero — inválido)
* B2 = {1} (Período mínimo válido — 1 dia)
* B3 = {365; 366} (Transição P1 → P2 — limite de 1 ano)
* B4 = {730} (Limite máximo do domínio monitorado)

**Total de bordas identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | período = 0 dias | B1 | HTTP 400 — "Período mínimo é de 1 dia." |
| CT2 | período = 1 dia | B2 | HTTP 200 — Histórico das últimas 24h retornado. |
| CT3 | período = 365 dias | B3 | HTTP 200 — Histórico do último ano retornado. |
| CT4 | período = 366 dias | B3 | HTTP 400 — "Período máximo é de 365 dias." |
| CT5 | período = 730 dias | B4 | HTTP 400 — Período fora do limite aceitável. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas: B1 (CT1), B2 (CT2), B3 (CT3 e CT4), B4 (CT5).
* Total de bordas: 4
* **TC = 4 / 4 = 100%**
