**Responsável:** João Gabriel Brito

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-03 (Gerar alertas de risco) / RF-05 (Não gerar alertas desnecessários) / RN-004 / F07 / F08

### 1. Regras e Modelagem (DT)

**Condições de Entrada (baseadas em RN-004):**
1. pH está fora do intervalo seguro (pH < 6,0 ou pH > 9,5)?
2. Turbidez está acima do limite seguro (turbidez > 40 NTU)?
3. Coliformes foram detectados (coliformes > 0 UFC/100ml)?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| pH fora do limite? | Sim | Sim | Sim | Sim | Não | Não | Não | Não |
| Turbidez > 40 NTU? | Sim | Sim | Não | Não | Sim | Sim | Não | Não |
| Coliformes > 0? | Sim | Não | Sim | Não | Sim | Não | Sim | Não |
| **Ação (Saída)** | ALERTA | ALERTA | ALERTA | ALERTA | ALERTA | ALERTA | ALERTA | **SEM ALERTA** |

**Observação:** Apenas quando TODOS os parâmetros estão dentro dos limites (R8) nenhum alerta deve ser gerado. Qualquer violação isolada já dispara alerta.

**Total de regras identificadas:** 8

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | pH=5,0, turbidez=50 NTU, coliformes=5 UFC | R1 | Alerta crítico gerado — múltiplos parâmetros violados. |
| CT2 | pH=5,0, turbidez=50 NTU, coliformes=0 | R2 | Alerta gerado — pH e turbidez violados. |
| CT3 | pH=5,0, turbidez=10 NTU, coliformes=2 UFC | R3 | Alerta gerado — pH e coliformes violados. |
| CT4 | pH=5,0, turbidez=10 NTU, coliformes=0 | R4 | Alerta gerado — somente pH violado. |
| CT5 | pH=7,2, turbidez=50 NTU, coliformes=5 UFC | R5 | Alerta gerado — turbidez e coliformes violados. |
| CT6 | pH=7,2, turbidez=50 NTU, coliformes=0 | R6 | Alerta gerado — somente turbidez violada. |
| CT7 | pH=7,2, turbidez=10 NTU, coliformes=2 UFC | R7 | Alerta gerado — somente coliformes detectados. |
| CT8 | pH=7,2, turbidez=10 NTU, coliformes=0 | R8 | **Sem alerta** — todos os parâmetros dentro da normalidade. |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 8 (R1 a R8).
* Total de regras da tabela: 8
* **TC = 8 / 8 = 100%**
