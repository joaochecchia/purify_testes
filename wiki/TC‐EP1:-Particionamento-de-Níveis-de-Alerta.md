**Responsável:** João Siqueira

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-03 / RF-04 / RN-004

### 1. Regras e Modelagem (EP)

**Variável analisada:** Combinação de parâmetros hídricos que determinam o nível de alerta

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Sem alerta | Todos os parâmetros dentro dos limites seguros | Nenhum alerta disparado |
| P2 | Alerta moderado | Um parâmetro fora do limite (ex: apenas turbidez > 40 NTU) | Alerta gerado; push notification enviada |
| P3 | Alerta crítico | Múltiplos parâmetros fora do limite (pH + coliformes) | Alerta crítico; push notification urgente + e-mail para ONG/Gov. |
| P4 | Dados ausentes | Nenhum dado disponível para a região | Região marcada "Indisponível"; sem alerta |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | pH=7,2; turbidez=10; coliformes=0 | P1 | Nenhum alerta gerado. |
| CT2 | pH=7,2; turbidez=55; coliformes=0 | P2 | Alerta moderado gerado; push notification enviada. |
| CT3 | pH=4,5; turbidez=80; coliformes=10 | P3 | Alerta crítico gerado; push + e-mail para autoridades. |
| CT4 | Região sem nenhum dado cadastrado | P4 | Região exibida como "Indisponível"; sem alerta. |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4).
* Total de partições: 4
* **TC = 4 / 4 = 100%**
