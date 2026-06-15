**Responsável:** João Gabriel Brito

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** F10 (Coliformes aceita valor negativo) / RN-004 — Portaria GM/MS nº 888/2021

### 1. Regras e Modelagem (BVA2)

**Regra (RN-004):** O sistema deve gerar alerta quando coliformes > 0 UFC/100ml. Qualquer detecção de coliformes configura risco. O valor mínimo válido é 0 (ausência total). Valores negativos devem ser rejeitados como inválidos.

**Domínio:** 0 ≤ coliformes ≤ 10000 UFC/100ml (DECIMAL).

**Partições:**

* P0 (Inválido): coliformes < 0 → deve ser rejeitado pela validação
* P1 (Seguro — sem alerta): coliformes = 0
* P2 (Alerta): 0 < coliformes ≤ 10000

**Identificação das Bordas:**

* B0 = {-1} (Valor inválido — abaixo do mínimo aceitável)
* B1 = {0} (Única borda da partição segura — ausência total de coliformes)
* B2 = {0; 0,1} (Transição P1 → P2 — limiar de alerta)
* B3 = {10000} (Borda superior do domínio definido)

**Total de bordas identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | coliformes = -1 | B0 | HTTP 400 — Valor inválido. "Coliformes não pode ser negativo." |
| CT2 | coliformes = 0 | B1 | **Sem alerta** — Água segura quanto a coliformes. |
| CT3 | coliformes = 0,1 | B2 | Alerta gerado — Presença mínima de coliformes detectada. |
| CT4 | coliformes = 10000 | B3 | Alerta crítico gerado — Contaminação severa. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas completas: B0 (CT1), B1 (CT2), B2 (CT2 e CT3), B3 (CT4).
* Total de bordas testadas: 4
* **TC = 4 / 4 = 100%**
