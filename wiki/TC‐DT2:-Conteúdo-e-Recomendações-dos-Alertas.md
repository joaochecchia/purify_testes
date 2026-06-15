**Responsável:** João Gabriel Brito Checchia

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-06 (Incluir recomendações nos alertas) / F12

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O alerta envolve coliformes detectados (risco microbiológico)?
2. O alerta envolve pH fora da faixa segura?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| Coliformes detectados? | Sim | Sim | Não | Não |
| pH fora da faixa? | Sim | Não | Sim | Não |
| **Recomendação (Saída)** | "Água imprópria para consumo e contato" | "Água imprópria para consumo" | "Evite contato prolongado com a água" | Recomendação genérica de monitoramento |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | coliformes=10; pH=4,5 | R1 | Alerta com recomendação: "Água imprópria para consumo e contato." |
| CT2 | coliformes=5; pH=7,2 | R2 | Alerta com recomendação: "Água imprópria para consumo." |
| CT3 | coliformes=0; pH=10,5 | R3 | Alerta com recomendação: "Evite contato prolongado com a água." |
| CT4 | coliformes=0; pH=7,2; turbidez=50 | R4 | Alerta com recomendação genérica de cautela e monitoramento. |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
