**Responsável:** João Gabriel Brito Checchia

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** RF-12 (Validar dados de cadastro) / RNF-007

### 1. Regras e Modelagem (BVA2)

**Regra:** A senha deve ter no mínimo **8 caracteres**. Deve conter pelo menos 1 letra maiúscula e 1 número. Limite técnico máximo definido como 128 caracteres.

**Domínio:** 0 ≤ len(senha) ≤ 128.

**Partições:**

* P0 (Inválido): len(senha) < 8
* P1 (Potencialmente válido): 8 ≤ len(senha) ≤ 128 (ainda sujeito a regras de complexidade)
* P2 (Inválido): len(senha) > 128

**Identificação das Bordas:**

* B1 = {0} (Senha vazia)
* B2 = {7; 8} (Transição P0 → P1 — mínimo de caracteres)
* B3 = {128; 129} (Transição P1 → P2 — máximo de senha)

**Total de bordas identificadas:** 3

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | senha = "" | B1 | HTTP 400 — "Senha é obrigatória." |
| CT2 | senha = "Abc123!" (7 chars) | B2 | HTTP 400 — "A senha deve ter no mínimo 8 caracteres, 1 maiúscula e 1 número." |
| CT3 | senha = "Abc1234!" (8 chars, válida) | B2 | HTTP 201 — Senha aceita. |
| CT4 | senha = "abc12345" (8 chars, sem maiúscula) | B2 | HTTP 400 — Senha sem letra maiúscula. |
| CT5 | senha = string de 128 chars (válida) | B3 | HTTP 201 — Senha aceita. |
| CT6 | senha = string de 129 chars | B3 | HTTP 400 — "Senha excede o limite de 128 caracteres." |

### 3. Taxa de Cobertura (TC)

* Bordas testadas: B1 (CT1), B2 (CT2, CT3, CT4), B3 (CT5 e CT6).
* Total de bordas: 3
* **TC = 3 / 3 = 100%**
