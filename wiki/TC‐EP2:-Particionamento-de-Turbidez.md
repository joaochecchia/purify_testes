**Responsável:** João Gabriel Brito

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-02 (Validar dados de qualidade da água) / F09 / RN-004 (turbidez > 40 NTU)

### 1. Regras e Modelagem (EP)

**Variável analisada:** Valor de turbidez (NTU) inserido no formulário de registro técnico

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Turbidez válida — segura | 0,0 ≤ turbidez ≤ 40,0 NTU | Dado aceito, sem alerta |
| P2 | Turbidez válida — alerta | turbidez > 40,0 NTU | Dado aceito, alerta de turbidez gerado |
| P3 | Turbidez inválida — negativa | turbidez < 0,0 | Dado rejeitado (HTTP 400) |
| P4 | Turbidez inválida — não numérica | turbidez = "turva" | Dado rejeitado (HTTP 400) |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | turbidez = 10,0 NTU | P1 | HTTP 201 — Dado salvo. Sem alerta. |
| CT2 | turbidez = 0,0 NTU | P1 | HTTP 201 — Dado salvo. Sem alerta. (água cristalina) |
| CT3 | turbidez = 55,0 NTU | P2 | HTTP 201 — Dado salvo. Alerta de turbidez gerado. |
| CT4 | turbidez = -5,0 | P3 | HTTP 400 — "Turbidez não pode ser negativa." |
| CT5 | turbidez = "turva" | P4 | HTTP 400 — "Formato inválido. Turbidez deve ser numérica (NTU)." |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1, CT2), P2 (CT3), P3 (CT4), P4 (CT5).
* Total de partições: 4
* **TC = 4 / 4 = 100%**
