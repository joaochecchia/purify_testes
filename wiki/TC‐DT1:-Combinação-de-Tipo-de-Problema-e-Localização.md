**Responsável:** João Gabriel Brito Checchia

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-22 / RF-21 / RN-007 / F14

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O tipo de problema está selecionado?
2. A localização GPS está disponível ou foi selecionada manualmente?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| Tipo selecionado? | Sim | Sim | Não | Não |
| Localização disponível? | Sim | Não | Sim | Não |
| **Ação (Saída)** | PERMITIR envio | BLOQUEAR — sem localização | BLOQUEAR — sem tipo | BLOQUEAR — ambos ausentes |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | tipo="VAZAMENTO"; lat=-15.7890; lon=-48.1234 | R1 | HTTP 201 — Reporte criado com sucesso. |
| CT2 | tipo="ESGOTO_ABERTO"; sem localização GPS | R2 | HTTP 400 — "Localização obrigatória para reportar ocorrência." |
| CT3 | Sem tipo selecionado; localização disponível | R3 | HTTP 400 — "Selecione um tipo de problema." |
| CT4 | Sem tipo e sem localização | R4 | HTTP 400 — Múltiplos campos obrigatórios ausentes. |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
