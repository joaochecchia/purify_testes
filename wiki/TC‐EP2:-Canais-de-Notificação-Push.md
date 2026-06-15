**Responsável:** João Siqueira

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-04 (Exibir alertas ao usuário) / F11

### 1. Regras e Modelagem (EP)

**Variável analisada:** Canal de entrega da notificação de alerta de risco hídrico

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Morador com GPS ativo na área crítica | App aberto, GPS dentro do raio da área de alerta | Pop-up de alerta exibido imediatamente no app |
| P2 | Morador com app em segundo plano | App instalado mas não aberto; GPS ativo | Push notification enviada ao dispositivo via FCM/APNS |
| P3 | ONG/Governante cadastrado na região | Usuário técnico responsável pela região afetada | Push notification + e-mail de notificação crítica |
| P4 | Usuário sem permissão de notificação | Usuário negou permissão de push notification | Nenhuma notificação push; apenas alerta visível ao abrir o app |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | Alerta gerado, Cláudia com app aberto e GPS no raio crítico | P1 | Pop-up de alerta exibido imediatamente. |
| CT2 | Alerta gerado, Cláudia com app em background | P2 | Push notification recebida no dispositivo. |
| CT3 | Alerta crítico gerado para região gerida por Rafael (ONG) | P3 | Push + e-mail enviados a Rafael. |
| CT4 | Alerta gerado, usuário sem permissão de push | P4 | Sem push; alerta visível ao abrir o app manualmente. |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4).
* Total de partições: 4
* **TC = 4 / 4 = 100%**
