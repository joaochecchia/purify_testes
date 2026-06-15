**Responsável:** João Gabriel Brito Checchia

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** RNF-013 (Tempo de resposta em notificações ≤ 30 segundos) / F13

### 1. Regras e Modelagem (BVA2)

**Regra (RNF-013):** A notificação push deve ser entregue ao dispositivo em até 30 segundos após a detecção do parâmetro crítico. Domínio: 0 ≤ tempo (segundos) ≤ 300.

**Partições:**

* P1 (Aceito): 0 ≤ tempo ≤ 30 segundos
* P2 (Violação de SLA): 30 < tempo ≤ 300 segundos

**Identificação das Bordas:**

* B1 = {0} (Entrega imediata)
* B2 = {30; 31} (Transição — limite do SLA de notificação)
* B3 = {300} (Limite máximo do domínio de monitoramento)

**Total de bordas identificadas:** 3

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | tempo de entrega = 0 segundos | B1 | Notificação aceita — entrega imediata. |
| CT2 | tempo de entrega = 30 segundos | B2 | Notificação aceita — no limite do SLA. |
| CT3 | tempo de entrega = 31 segundos | B2 | **Violação de SLA** — log de atraso gerado; alerta de monitoramento. |
| CT4 | tempo de entrega = 300 segundos | B3 | Violação grave — escalonamento de incidente. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas: B1 (CT1), B2 (CT2 e CT3), B3 (CT4).
* Total de bordas: 3
* **TC = 3 / 3 = 100%**
