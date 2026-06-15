**Responsável:** João Gabriel Brito

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** F06 / F07 (Alerta não gerado quando pH ultrapassa 9,5 / pH fora do intervalo [0,14] aceito) — RN-004

### 1. Regras e Modelagem (BVA2)

**Regra (RN-004):** O sistema deve gerar alerta quando pH < 6,0 **ou** pH > 9,5. O pH deve ser validado no intervalo [0, 14].

**Domínio:** 0,0 ≤ pH ≤ 14,0 (DECIMAL com 1 casa).

**Partições:**

* P1 (Alerta — Ácido): 0,0 ≤ pH < 6,0
* P2 (Seguro — sem alerta): 6,0 ≤ pH ≤ 9,5
* P3 (Alerta — Alcalino): 9,5 < pH ≤ 14,0

**Identificação das Bordas:**

* B1 = {0,0} (Borda inferior do domínio — mínimo absoluto de pH)
* B2 = {5,9; 6,0} (Transição P1 → P2 — limite inferior de segurança)
* B3 = {9,5; 9,6} (Transição P2 → P3 — limite superior de segurança)
* B4 = {14,0} (Borda superior do domínio — máximo absoluto de pH)

**Total de bordas identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | pH = 0,0 | B1 | Alerta gerado — pH ácido fora do limite seguro. |
| CT2 | pH = 5,9 | B2 | Alerta gerado — pH ainda dentro da zona ácida crítica. |
| CT3 | pH = 6,0 | B2 | **Sem alerta** — pH no limite inferior seguro (borda inclusiva). |
| CT4 | pH = 9,5 | B3 | **Sem alerta** — pH no limite superior seguro (borda inclusiva). |
| CT5 | pH = 9,6 | B3 | Alerta gerado — pH acima do limite alcalino seguro. |
| CT6 | pH = 14,0 | B4 | Alerta gerado — pH no máximo absoluto do domínio. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas completas: B1 (CT1), B2 (CT2 e CT3), B3 (CT4 e CT5), B4 (CT6).
* Total de bordas testadas: 4
* **TC = 4 / 4 = 100%**
