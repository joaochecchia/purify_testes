**Responsável:** Luan Ferreira

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** RF-21 (Informar localização do problema via GPS) / RN-007 / F14

### 1. Regras e Modelagem (BVA2)

**Regra (RN-007):** O reporte de saneamento deve conter coordenadas GPS com precisão de no mínimo **4 casas decimais** (±11 metros de precisão). Coordenadas com menos casas decimais devem ser rejeitadas como insuficientemente precisas.

**Domínio (casas decimais de latitude/longitude):** 0 ≤ casas ≤ 8.

**Partições:**

* P1 (Inválido — impreciso): 0 ≤ casas < 4
* P2 (Válido): 4 ≤ casas ≤ 8

**Identificação das Bordas:**

* B1 = {0} (Sem casas decimais — latitude/longitude inteira)
* B2 = {3; 4} (Transição P1 → P2 — limiar de precisão aceitável)
* B3 = {8} (Precisão máxima do GPS consumer)

**Total de bordas identificadas:** 3

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | lat=-15, lon=-48 (0 casas) | B1 | HTTP 400 — Precisão GPS insuficiente. |
| CT2 | lat=-15.789, lon=-48.123 (3 casas) | B2 | HTTP 400 — Precisão GPS insuficiente. |
| CT3 | lat=-15.7890, lon=-48.1234 (4 casas) | B2 | HTTP 201 — Reporte aceito com localização válida. |
| CT4 | lat=-15.78901234, lon=-48.12345678 (8 casas) | B3 | HTTP 201 — Reporte aceito com alta precisão. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas: B1 (CT1), B2 (CT2 e CT3), B3 (CT4).
* Total de bordas: 3
* **TC = 3 / 3 = 100%**
