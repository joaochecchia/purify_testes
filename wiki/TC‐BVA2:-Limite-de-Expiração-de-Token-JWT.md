**Responsável:** Daniel Souza

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** F03 (Token JWT gerado sem data de expiração — RNF-004)

### 1. Regras e Modelagem (BVA2)

**Regra:** O token JWT deve expirar em exatamente 2 horas (7200 segundos) após a emissão. Requisições com tokens válidos devem ser aceitas; com tokens expirados, devem ser rejeitadas com HTTP 401.

**Domínio:** 0 ≤ tempo_desde_emissão (segundos) ≤ 14400 (limite arbitrário de 4h).

**Partições:**

* P1 (Token Válido): 0 ≤ tempo ≤ 7200
* P2 (Token Expirado): 7201 ≤ tempo ≤ 14400

**Identificação das Bordas:**

* B1 = {0} (Emissão imediata — válido)
* B2 = {7200, 7201} (Transição P1 → P2 — janela de expiração)
* B3 = {14400} (Borda máxima do domínio — expirado)

**Total de bordas identificadas:** 3

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | token com 0 segundos de vida | B1 | Requisição aceita (HTTP 200). |
| CT2 | token com 7200 segundos de vida (exatamente) | B2 | Requisição aceita (HTTP 200). |
| CT3 | token com 7201 segundos de vida (1 segundo após expirar) | B2 | Requisição rejeitada (HTTP 401 Unauthorized). |
| CT4 | token com 14400 segundos de vida | B3 | Requisição rejeitada (HTTP 401 Unauthorized). |

### 3. Taxa de Cobertura (TC)

* Bordas testadas completas: B1 (CT1), B2 (CT2 e CT3), B3 (CT4).
* Total de bordas testadas: 3
* **TC = 3 / 3 = 100%**
