**Responsável:** João Gabriel Brito

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-02 (Validar dados de qualidade da água) / F06

### 1. Regras e Modelagem (EP)

**Variável analisada:** Valor de pH inserido no formulário de registro técnico

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | pH válido — seguro | 6,0 ≤ pH ≤ 9,5 | Dado aceito, sem alerta gerado |
| P2 | pH válido — alerta ácido | 0,0 ≤ pH < 6,0 | Dado aceito, alerta de risco gerado |
| P3 | pH válido — alerta alcalino | 9,5 < pH ≤ 14,0 | Dado aceito, alerta de risco gerado |
| P4 | pH inválido — abaixo do mínimo | pH < 0,0 | Dado rejeitado (HTTP 400) |
| P5 | pH inválido — acima do máximo | pH > 14,0 | Dado rejeitado (HTTP 400) |
| P6 | pH inválido — não numérico | pH = "abc" | Dado rejeitado (HTTP 400) |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | pH = 7,2 | P1 | HTTP 201 — Dado salvo. Sem alerta. |
| CT2 | pH = 4,5 | P2 | HTTP 201 — Dado salvo. Alerta de pH ácido gerado. |
| CT3 | pH = 10,0 | P3 | HTTP 201 — Dado salvo. Alerta de pH alcalino gerado. |
| CT4 | pH = -2,0 | P4 | HTTP 400 — "Valor de pH inválido. Informe um valor entre 0 e 14." |
| CT5 | pH = 15,0 | P5 | HTTP 400 — "Valor de pH inválido. Informe um valor entre 0 e 14." |
| CT6 | pH = "neutro" | P6 | HTTP 400 — "Formato inválido. pH deve ser numérico." |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4), P5 (CT5), P6 (CT6).
* Total de partições: 6
* **TC = 6 / 6 = 100%**
