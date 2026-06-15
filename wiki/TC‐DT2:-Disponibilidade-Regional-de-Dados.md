**Responsável:** João Gabriel Brito Checchia

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-10 (Informar ausência de histórico) / RF-16 (Ausência de dados de saneamento) / RN-002 / F18

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. Existem dados de qualidade da água para a região?
2. Existem dados de saneamento para a região?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| Dados de qualidade? | Sim | Sim | Não | Não |
| Dados de saneamento? | Sim | Não | Sim | Não |
| **Ação (Saída)** | Exibir dashboard completo | Dashboard de qualidade; aviso saneamento indisponível | Aviso qualidade indisponível; dashboard de saneamento | Região marcada "Indisponível" em ambas seções |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | Região com dados de qualidade E saneamento | R1 | Dashboard completo exibido. |
| CT2 | Região com dados de qualidade; sem saneamento | R2 | Dashboard de qualidade exibido; seção saneamento: "Dados indisponíveis." |
| CT3 | Região sem dados de qualidade; com saneamento | R3 | Seção qualidade: "Dados indisponíveis."; dashboard de saneamento exibido. |
| CT4 | Região sem nenhum dado | R4 | Ambas seções: "Não há dados para esta região." |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
