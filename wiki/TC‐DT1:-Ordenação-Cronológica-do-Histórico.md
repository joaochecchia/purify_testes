**Responsável:** Victor Davidson

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-09 (Exibir histórico em ordem cronológica) / RN-005 / F17

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O filtro de região foi informado?
2. Existem registros históricos para a região no período selecionado?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| Região informada? | Sim | Sim | Não | Não |
| Registros existentes? | Sim | Não | Sim | Não |
| **Ação (Saída)** | Retornar lista ORDER BY data DESC | Exibir "Não há dados para este período" | HTTP 400 — região obrigatória | HTTP 400 — região obrigatória |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | região="Guará"; 3 registros de datas distintas | R1 | Lista retornada com o mais recente no índice 0 (ORDER BY timestamp DESC). |
| CT2 | região="Gama"; período sem dados (30 dias) | R2 | HTTP 200 com lista vazia + mensagem "Não há dados para este período." |
| CT3 | Sem parâmetro de região; registros existentes | R3 | HTTP 400 — "Selecione uma região para consultar o histórico." |
| CT4 | Sem parâmetro de região; sem dados | R4 | HTTP 400 — "Selecione uma região para consultar o histórico." |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
