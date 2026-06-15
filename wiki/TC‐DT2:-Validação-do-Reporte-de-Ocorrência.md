**Responsável:** João Gabriel Brito Checchia

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-23 (Validar informações do problema) / RF-24 (Registrar ocorrência) / F15 / F16

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. A descrição do problema foi preenchida (≥ 10 caracteres)?
2. O reporte é duplicado (mesmo usuário, mesmo tipo, mesma localização, últimas 24h)?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| Descrição preenchida? | Sim | Sim | Não | Não |
| Reporte duplicado? | Sim | Não | Sim | Não |
| **Ação (Saída)** | AVISO de duplicata; permitir ou cancelar | CRIAR ocorrência | BLOQUEAR | BLOQUEAR — descrição ausente |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | Descrição="Vazamento na rua X"; idêntico ao reporte enviado há 2h | R1 | Aviso: "Você já reportou um problema semelhante hoje. Deseja enviar novamente?" |
| CT2 | Descrição="Vazamento na rua X"; primeiro reporte dessa localização | R2 | HTTP 201 — Ocorrência registrada e vinculada ao usuário. |
| CT3 | Descrição="" (vazia); reporte duplicado | R3 | HTTP 400 — "Por favor, descreva o problema antes de enviar." |
| CT4 | Descrição="" (vazia); primeiro reporte | R4 | HTTP 400 — "Por favor, descreva o problema antes de enviar." |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
