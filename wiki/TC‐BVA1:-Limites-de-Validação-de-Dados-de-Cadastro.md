**Responsável:** João Gabriel Brito Checchia

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** RF-12 (Validar dados de cadastro) / F04

### 1. Regras e Modelagem (BVA2)

**Regra:** O campo "nome completo" do cadastro deve ter no mínimo **3 caracteres** e no máximo **100 caracteres**.

**Domínio:** 0 ≤ len(nome) ≤ 200.

**Partições:**

* P0 (Inválido): len(nome) < 3
* P1 (Válido): 3 ≤ len(nome) ≤ 100
* P2 (Inválido): len(nome) > 100

**Identificação das Bordas:**

* B1 = {0} (Nome vazio)
* B2 = {2; 3} (Transição P0 → P1 — mínimo de caracteres)
* B3 = {100; 101} (Transição P1 → P2 — máximo de caracteres)
* B4 = {200} (Limite superior do domínio)

**Total de bordas identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | nome = "" (vazio) | B1 | HTTP 400 — "Nome é obrigatório." |
| CT2 | nome = "Jo" (2 chars) | B2 | HTTP 400 — "Nome deve ter ao menos 3 caracteres." |
| CT3 | nome = "Ana" (3 chars) | B2 | HTTP 201 — Cadastro aceito. |
| CT4 | nome = string de 100 chars | B3 | HTTP 201 — Cadastro aceito. |
| CT5 | nome = string de 101 chars | B3 | HTTP 400 — "Nome excede o limite de 100 caracteres." |
| CT6 | nome = string de 200 chars | B4 | HTTP 400 — Nome excede o limite. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas: B1 (CT1), B2 (CT2 e CT3), B3 (CT4 e CT5), B4 (CT6).
* Total de bordas: 4
* **TC = 4 / 4 = 100%**
