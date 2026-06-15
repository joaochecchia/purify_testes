**Responsável:** João Gabriel Brito Checchia

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-22 (Descrever problema de saneamento)

### 1. Regras e Modelagem (EP)

**Variável analisada:** Tipo de problema selecionado no formulário de reporte

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Tipo válido — Vazamento | Usuário seleciona "Vazamento" no enum de tipos | Tipo aceito; formulário habilitado para envio |
| P2 | Tipo válido — Esgoto aberto | Usuário seleciona "Esgoto aberto" | Tipo aceito |
| P3 | Tipo válido — Falta de coleta | Usuário seleciona "Falta de coleta de lixo/esgoto" | Tipo aceito |
| P4 | Tipo inválido — Sem seleção | Usuário não selecionou nenhum tipo | HTTP 400 — "Selecione um tipo de problema." |
| P5 | Tipo inválido — Valor fora do enum | Injeção de tipo não listado via API ("tipo_novo") | HTTP 400 — "Tipo de problema inválido." |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | tipo = "VAZAMENTO" | P1 | HTTP 201 — Reporte registrado. |
| CT2 | tipo = "ESGOTO_ABERTO" | P2 | HTTP 201 — Reporte registrado. |
| CT3 | tipo = "FALTA_COLETA" | P3 | HTTP 201 — Reporte registrado. |
| CT4 | tipo = null (sem seleção) | P4 | HTTP 400 — "Selecione um tipo de problema." |
| CT5 | tipo = "tipo_inventado" | P5 | HTTP 400 — "Tipo de problema inválido." |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4), P5 (CT5).
* Total de partições: 5
* **TC = 5 / 5 = 100%**
