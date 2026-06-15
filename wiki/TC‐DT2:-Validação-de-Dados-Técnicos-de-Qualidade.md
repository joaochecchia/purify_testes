**Responsável:** João Gabriel Brito

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-02 (Validar dados de qualidade da água) / RF-18 / F06 / F09 / F10

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O valor de pH está dentro do domínio válido ([0, 14])?
2. O valor de turbidez está dentro do domínio válido (≥ 0)?
3. O valor de coliformes está dentro do domínio válido (≥ 0)?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| pH válido? | Sim | Sim | Sim | Sim | Não | Não | Não | Não |
| Turbidez válida? | Sim | Sim | Não | Não | Sim | Sim | Não | Não |
| Coliformes válido? | Sim | Não | Sim | Não | Sim | Não | Sim | Não |
| **Ação (Saída)** | SALVAR | REJEITAR | REJEITAR | REJEITAR | REJEITAR | REJEITAR | REJEITAR | REJEITAR |

**Observação:** Apenas quando TODOS os três campos estão válidos o registro é salvo (R1). Qualquer campo inválido rejeita o registro com HTTP 400 e mensagem específica.

**Total de regras identificadas:** 8

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | pH=7,2; turbidez=15; coliformes=0 | R1 | HTTP 201 — Dados salvos com sucesso. |
| CT2 | pH=7,2; turbidez=15; coliformes=-1 | R2 | HTTP 400 — "Coliformes não pode ser negativo." |
| CT3 | pH=7,2; turbidez=-5; coliformes=0 | R3 | HTTP 400 — "Turbidez não pode ser negativa." |
| CT4 | pH=7,2; turbidez=-5; coliformes=-1 | R4 | HTTP 400 — Múltiplos erros de validação. |
| CT5 | pH=-2; turbidez=15; coliformes=0 | R5 | HTTP 400 — "pH inválido. Informe valor entre 0 e 14." |
| CT6 | pH=-2; turbidez=15; coliformes=-1 | R6 | HTTP 400 — Múltiplos erros de validação. |
| CT7 | pH=-2; turbidez=-5; coliformes=0 | R7 | HTTP 400 — Múltiplos erros de validação. |
| CT8 | pH=-2; turbidez=-5; coliformes=-1 | R8 | HTTP 400 — Todos os campos inválidos. |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 8 (R1 a R8).
* Total de regras da tabela: 8
* **TC = 8 / 8 = 100%**
