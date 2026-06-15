**Responsável:** Luan Ferreira

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-21 (Informar localização do problema) / UC-03 (Gestão de Permissões de GPS) / RN-007

### 1. Regras e Modelagem (EP)

**Variável analisada:** Estado de disponibilidade da localização GPS ao tentar reportar problema

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | GPS ativo e dentro da precisão | Localização capturada com ≥ 4 casas decimais | Localização anexada ao formulário automaticamente |
| P2 | GPS ativo mas impreciso | Localização com < 4 casas decimais (sinal fraco) | Aviso de precisão insuficiente; sugestão de seleção manual |
| P3 | GPS desativado no dispositivo | Permissão negada anteriormente | Orientação passo a passo para ativar GPS nas configurações |
| P4 | Seleção manual no mapa | Usuário seleciona ponto no mapa manualmente | Coordenadas do ponto selecionado usadas como localização |
| P5 | Sem GPS e sem seleção manual | Usuário tenta enviar sem qualquer localização | HTTP 400 — "Localização obrigatória para reportar ocorrência." |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | GPS ativo: lat=-15.7890; lon=-48.1234 | P1 | Localização capturada; botão de envio habilitado. |
| CT2 | GPS ativo mas impreciso: lat=-15.78; lon=-48.12 | P2 | Aviso exibido; sugestão de ajuste ou seleção manual. |
| CT3 | GPS desativado no dispositivo | P3 | Orientação de ativação de GPS exibida ao usuário. |
| CT4 | Seleção manual no mapa: ponto clicado | P4 | Coordenadas do ponto capturadas; formulário habilitado. |
| CT5 | Botão enviar sem GPS e sem seleção manual | P5 | HTTP 400 — "Localização obrigatória." |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4), P5 (CT5).
* Total de partições: 5
* **TC = 5 / 5 = 100%**
