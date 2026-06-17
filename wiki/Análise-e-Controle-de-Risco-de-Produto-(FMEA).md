Esta página apresenta a Análise de Modos de Falha e Efeitos (FMEA) focada no sistema **Purify**. O objetivo é identificar riscos técnicos que possam comprometer a saúde pública, a integridade dos dados hídricos e o cumprimento das Regras de Negócio estabelecidas. Esta análise foi realizada por **João Gabriel Brito Checchia**, garantindo a rastreabilidade com os Requisitos Funcionais (RF), Não Funcionais (RNF) e Regras de Negócio (RN) documentados no projeto.

## 2. Metodologia e Critérios de Pontuação

Para quantificar o risco, utilizamos três índices pontuados de **1 a 10**. A definição desses valores reflete o consenso do grupo baseado no impacto real que uma falha teria sobre a população que depende do sistema para saber se a água é segura para consumo.

### A. Severidade (S)
Mede a gravidade do efeito da falha para o usuário final.
* **9-10 (Crítica):** Falhas que colocam a saúde pública em risco (ex: alerta não gerado quando água está contaminada, ou alerta falso causando pânico desnecessário).
* **7-8 (Alta):** Falhas que causam perda de dados hídricos ou violação de privacidade do usuário.
* **4-6 (Média):** Falhas de usabilidade ou atrasos que geram transtornos, mas não risco imediato à saúde.
* **1-3 (Baixa):** Problemas estéticos ou de menor impacto na operação.

### B. Ocorrência (O)
Mede a probabilidade da causa da falha existir no software.
* **9-10 (Muito Alta):** Falha quase inevitável sem controles rigorosos.
* **5-8 (Moderada):** Falhas que ocorrem ocasionalmente.
* **1-4 (Remota/Baixa):** Falhas improváveis, que ocorrem apenas em condições de exceção.

### C. Detecção (D)
Mede a facilidade de detectar a falha através de testes antes que ela chegue ao usuário.
* **9-10 (Raríssima):** O sistema não possui validações para capturar o erro.
* **5-8 (Moderada):** Exige testes de integração complexos ou simulação de sensores físicos.
* **1-4 (Alta):** Facilmente identificada por testes unitários ou de interface simples.

### D. RPN (Risk Priority Number)

O **RPN**é o resultado da multiplicação: **S × O × D**.
Qualquer item com **RPN acima de 100** ou **Severidade Crítica (9-10)** exige a criação de uma ação de controle imediata (Testes listados na página "Controle de Risco").

## 3. Tabela FMEA do Produto

| ID | Responsável | Ref. Req. | Função do Sistema | Modo de Falha | Efeito do Erro | Causa(s) Potencial(is) | S | O | D | RPN | Ação Recomendada |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **F01** | João Gabriel Brito Checchia | RF-11, RF-12 | Autenticação | Permite infinitas tentativas de login sem bloqueio (Brute Force). | Conta invadida; acesso indevido a dados de usuários. | Falta de rate limiting na API de autenticação. | 8 | 3 | 2 | **48** | Teste de Limite de Requisições (Força Bruta). |
| **F02** | João Gabriel Brito Checchia | RF-19, RN-003 | Controle de Acesso | Perfil Morador consegue acessar e inserir dados técnicos de qualidade. | Dados hídricos falsos inseridos; alertas incorretos disparados. | Regra de RBAC não aplicada no endpoint de escrita. | 9 | 4 | 2 | **72** | Teste de Isolamento de Perfil (RBAC). |
| **F03** | João Gabriel Brito Checchia | RNF-004 | Segurança de Sessão | Token JWT gerado sem data de expiração. | Exposição de dados caso o dispositivo seja comprometido. | Token JWT gerado sem payload "exp". | 8 | 4 | 3 | **96** | Teste de Validade e Expiração de Token. |
| **F04** | João Gabriel Brito Checchia | RF-13, RN-006 | Unicidade de Cadastro | E-mail ou CPF/CNPJ duplicado aceito no cadastro. | Dois usuários com a mesma identidade no sistema. | Ausência de constraint UNIQUE no banco ou validação prévia. | 7 | 5 | 2 | **70** | Teste de Duplicidade de Cadastro. |
| **F05** | João Gabriel Brito Checchia | RNF-007 | Segurança de Dados | Senhas armazenadas em texto plano no banco de dados. | Vazamento crítico de credenciais em caso de acesso indevido ao banco. | Ausência de função de Hash (ex: bcrypt). | 10 | 2 | 7 | **140** | Teste Estático de Criptografia de Senhas. |
| **F06** | João Gabriel Brito Checchia | RF-02, RF-18 | Validação de pH | Dados de pH aceitos fora do intervalo válido [0, 14]. | Sistema armazena pH negativo ou > 14, corrompendo o histórico. | Ausência de validação de intervalo no formulário e na API. | 9 | 5 | 2 | **90** | Teste de Particionamento de pH. |
| **F07** | João Gabriel Brito Checchia | RF-03, RN-004 | Geração de Alerta de pH | Alerta não gerado quando pH ultrapassa 9,5. | Água alcalina imprópria para consumo sem aviso à população. | Erro lógico na condição ">" em vez de "≥" no gatilho. | 10 | 4 | 3 | **120** | Teste de Borda do Gatilho de pH. |
| **F08** | João Gabriel Brito Checchia | RF-05, RN-004 | Supressão de Alerta | Alerta gerado com parâmetros dentro da faixa normal. | Pânico desnecessário na população; perda de credibilidade do sistema. | Condição lógica invertida no módulo de verificação. | 6 | 4 | 2 | **48** | Teste de Ausência de Alerta com Dados Normais. |
| **F09** | João Gabriel Brito Checchia | RF-02 | Validação de Turbidez | Campo de turbidez aceita valores negativos. | Histórico corrompido com dados impossíveis. | Falta de validação de mínimo (≥ 0) no input. | 7 | 6 | 2 | **84** | Teste de Particionamento de Turbidez. |
| **F10** | João Gabriel Brito Checchia | RF-02 | Validação de Coliformes | Campo de coliformes aceita valor negativo ou texto não-numérico. | Histórico inválido; rotina de alertas com comportamento imprevisível. | Ausência de tipagem restrita e validação de mínimo no campo. | 8 | 5 | 2 | **80** | Teste de Particionamento de Coliformes. |
| **F11** | João Gabriel Brito Checchia | RF-04, RN-003 | Notificação Push | Push notification não enviada para moradores em alerta crítico. | Moradores não avisados sobre água contaminada. | Falha no serviço de mensageria (FCM/APNS). | 9 | 3 | 5 | **135** | Teste de Envio de Notificação Push Crítica. |
| **F12** | João Gabriel Brito Checchia | RF-06 | Conteúdo do Alerta | Alerta gerado sem recomendação de uso/restrição da água. | Usuário recebe alerta sem saber o que fazer. | Campo de recomendação não obrigatório no schema do alerta. | 7 | 4 | 3 | **84** | Teste de Conteúdo dos Alertas. |
| **F13** | João Gabriel Brito Checchia | RNF-001 | Desempenho da API | Tempo de resposta da API > 2 segundos em mais de 5% das requisições. | Experiência degradada; dados de sensores atrasados no dashboard. | Queries SQL sem índice em tabelas grandes de histórico. | 7 | 6 | 3 | **126** | Teste de Desempenho e Carga da API. |
| **F14** | João Gabriel Brito Checchia | RF-21, RN-007 | Reporte de Saneamento | Reporte enviado sem localização geográfica. | Ocorrência registrada sem localização; impossível acionar equipe de campo. | Validação de GPS obrigatória não implementada no backend. | 9 | 5 | 2 | **90** | Teste de Obrigatoriedade de Localização GPS. |
| **F15** | João Gabriel Brito Checchia | RF-23 | Validação do Reporte | Formulário de reporte enviado com campo de descrição vazio. | Ocorrência registrada sem informações suficientes para investigação. | Campo description não obrigatório na validação do formulário. | 6 | 7 | 2 | **84** | Teste de Validação de Descrição do Reporte. |
| **F16** | João Gabriel Brito Checchia | RF-24 | Registro de Ocorrência | Clique duplo no botão "Enviar Reporte" cria 2 ocorrências idênticas. | Histórico de saneamento com duplicatas; estatísticas infladas. | Ausência de debounce ou idempotência no endpoint POST. | 7 | 6 | 3 | **126** | Teste de Concorrência no Registro de Reporte. |
| **F17** | João Gabriel Brito Checchia | RF-09, RN-005 | Histórico Cronológico | Histórico exibido em ordem aleatória ou ascendente. | Usuário vê dados antigos primeiro; confusão na análise temporal. | Ausência de ORDER BY DESC no timestamp da query. | 6 | 5 | 3 | **90** | Teste de Ordenação do Histórico. |
| **F18** | João Gabriel Brito Checchia | RF-10, RN-002 | Ausência de Dados | Região sem dados não exibe mensagem de indisponibilidade. | Usuário vê tela em branco sem entender o motivo. | Ausência de tratamento de retorno vazio (empty state). | 5 | 5 | 3 | **75** | Teste de Exibição de Região Indisponível. |
| **F19** | João Gabriel Brito Checchia | RF-08, RN-002 | Filtro Regional | Dados de uma região A exibidos ao selecionar a região B. | Usuário toma decisões com base em dados errados. | Query SQL com filtro de ID_Regiao incorreto ou ausente. | 8 | 3 | 4 | **96** | Teste de Isolamento de Dados por Região. |
| **F20** | João Gabriel Brito Checchia | RN-008 | Exclusão de Conta | Exclusão de conta não anonimiza os reportes de saneamento do usuário. | Violação da LGPD; dados pessoais do usuário persistem vinculados. | Procedure de exclusão não implementa UPDATE de anonimização. | 9 | 4 | 4 | **144** | Teste de Anonimização na Exclusão de Conta. |

## 4. Matriz FMEA (Severidade × Ocorrência)

A matriz abaixo posiciona os riscos identificados pelo grupo. As falhas localizadas no quadrante **Crítico/Alta** foram priorizadas para a modelagem de testes que compõem o nosso Plano de Qualidade.

| Ocorrência \ Severidade | Baixa (1-3) | Média (4-6) | Alta (7-8) | Crítica (9-10) |
| :--- | :---: | :---: | :---: | :---: |
| **Alta (7-8)** | - | F15 | F09 | - |
| **Média (4-6)** | - | F08, F18 | F03, F10, F12, F13, F16, F17, F19 | **F06, F07, F11, F14** |
| **Baixa (1-3)** | - | - | F01, F04 | **F02, F05, F20** |
