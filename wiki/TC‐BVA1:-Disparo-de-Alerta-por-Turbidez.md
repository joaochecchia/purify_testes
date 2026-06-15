**Responsável:** João Gabriel Brito Checchia

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** RN-004 (turbidez > 40 NTU dispara alerta) / RF-03

### 1. Regras e Modelagem (BVA2)

**Regra (RN-004):** O sistema deve gerar alerta quando turbidez > 40 NTU. Domínio válido: 0 ≤ turbidez ≤ 1000 NTU.

**Partições:**

* P1 (Seguro — sem alerta): 0 ≤ turbidez ≤ 40 NTU
* P2 (Alerta): 40 < turbidez ≤ 1000 NTU

**Identificação das Bordas:**

* B1 = {0} (Mínimo do domínio — água cristalina)
* B2 = {40; 41} (Transição P1 → P2 — limiar de alerta de turbidez)
* B3 = {1000} (Máximo do domínio)

**Total de bordas identificadas:** 3

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | turbidez = 0 NTU | B1 | Sem alerta — água limpa. |
| CT2 | turbidez = 40 NTU | B2 | **Sem alerta** — exatamente no limite (borda inclusiva segura). |
| CT3 | turbidez = 41 NTU | B2 | Alerta gerado — turbidez acima do limite. |
| CT4 | turbidez = 1000 NTU | B3 | Alerta gerado — turbidez extremamente alta. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas: B1 (CT1), B2 (CT2 e CT3), B3 (CT4).
* Total de bordas: 3
* **TC = 3 / 3 = 100%**
