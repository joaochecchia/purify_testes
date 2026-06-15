**Responsável:** Luan Ferreira

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** RF-23 (Validar informações do problema) / F15

### 1. Regras e Modelagem (BVA2)

**Regra:** O campo de descrição do problema de saneamento deve ter no mínimo **10 caracteres** e no máximo **500 caracteres**.

**Domínio:** 0 ≤ len(descricao) ≤ 1000 (Inteiros).

**Partições:**

* P0 (Inválido — muito curto): 0 ≤ len < 10
* P1 (Válido): 10 ≤ len ≤ 500
* P2 (Inválido — muito longo): 500 < len ≤ 1000

**Identificação das Bordas:**

* B1 = {0} (Campo vazio)
* B2 = {9; 10} (Transição P0 → P1 — mínimo aceitável)
* B3 = {500; 501} (Transição P1 → P2 — máximo aceitável)
* B4 = {1000} (Limite superior do domínio)

**Total de bordas identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | descricao = "" (vazio) | B1 | HTTP 400 — "Por favor, descreva o problema antes de enviar." |
| CT2 | descricao = "Vazament" (9 chars) | B2 | HTTP 400 — Descrição muito curta. |
| CT3 | descricao = "Vazamento " (10 chars) | B2 | HTTP 201 — Reporte registrado com sucesso. |
| CT4 | descricao = string de 500 chars | B3 | HTTP 201 — Reporte registrado com sucesso. |
| CT5 | descricao = string de 501 chars | B3 | HTTP 400 — "Descrição excede o limite de 500 caracteres." |
| CT6 | descricao = string de 1000 chars | B4 | HTTP 400 — Descrição excede o limite. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas: B1 (CT1), B2 (CT2 e CT3), B3 (CT4 e CT5), B4 (CT6).
* Total de bordas: 4
* **TC = 4 / 4 = 100%**
