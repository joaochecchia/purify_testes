**Responsável:** João Gabriel Brito Checchia

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RN-001 / RN-002 / RN-003 (Alertas e notificações por nível de gravidade)

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O alerta gerado é classificado como grave (múltiplos parâmetros ou contaminantes)?
2. O usuário afetado é ONG/Governante?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| Alerta grave? | Sim | Sim | Não | Não |
| Usuário ONG/Gov.? | Sim | Não | Sim | Não |
| **Ação (Saída)** | Push + E-mail | Push apenas | Push + E-mail | Push apenas |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | Alerta grave (pH=4 + coliformes=50) para ONG (Rafael) | R1 | Push notification + e-mail enviados a Rafael. |
| CT2 | Alerta grave (pH=4 + coliformes=50) para Morador (Cláudia) | R2 | Push notification enviada a Cláudia; sem e-mail. |
| CT3 | Alerta leve (turbidez=45 NTU apenas) para ONG | R3 | Push notification + e-mail enviados à ONG. |
| CT4 | Alerta leve (turbidez=45 NTU apenas) para Morador | R4 | Push notification enviada; sem e-mail. |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
