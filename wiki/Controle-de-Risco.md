>Esta página descreve as ações de controle elaboradas para mitigar os Modos de Falha mapeados no FMEA do sistema **Purify**. As ações baseiam-se em metodologias de testes dinâmicos (caixa-preta, particionamento de equivalência e análise de valor limite) e validam diretamente os Requisitos e Regras de Negócio do sistema.

---

### Ações de Controle (Autenticação e Segurança)
>`Responsável: Daniel Souza`

**1. Teste de Limite de Requisições (Força Bruta)**
* **Descrição sucinta do teste:** Simulação de ataques de força bruta inserindo 10 senhas erradas no endpoint de login em menos de 1 minuto. O sistema deve validar o RF-11 retornando código *HTTP 429 Too Many Requests* ou bloqueando o IP temporariamente.
* **Modo de falha controlado:** [F01] Permite infinitas tentativas erradas de login.

**2. Teste de Isolamento de Perfil (RBAC)**
* **Descrição sucinta do teste:** Utilizando o token de um usuário com perfil "Morador", o script tentará invocar a rota de registro técnico de dados (exclusiva de ONG/Governante). O sistema deve garantir o RNF-006 retornando erro de autorização *HTTP 403 Forbidden*.
* **Modo de falha controlado:** [F02] Perfil Morador consegue inserir dados técnicos.

**3. Teste de Validade e Expiração de Token**
* **Descrição sucinta do teste:** Decodificação estática do payload do token JWT gerado no login para afirmar que a chave `exp` (expiration) existe e está configurada para um limite seguro (ex: 2 horas), validando o RNF-004.
* **Modo de falha controlado:** [F03] Token de sessão JWT sem data de expiração.

**4. Teste de Duplicidade de Cadastro**
* **Descrição sucinta do teste:** Tentativa de cadastro com e-mail já existente no banco e, em seguida, com CPF/CNPJ já existente. O sistema deve retornar mensagem de erro adequada e não criar conta duplicada (RN-006).
* **Modo de falha controlado:** [F04] E-mail ou CPF/CNPJ duplicado aceito no cadastro.

**5. Teste Estático de Criptografia de Senhas**
* **Descrição sucinta do teste:** Revisão de código (Caixa-Branca) e consulta direta ao banco de dados. Um script tenta ler a tabela de usuários para comprovar que todas as senhas passaram por funções de hashing seguro (bcrypt), validando o RNF-007.
* **Modo de falha controlado:** [F05] Senhas armazenadas em texto plano.

---

### Ações de Controle (Qualidade da Água e Alertas)
>`Responsável: João Gabriel Brito`

**6. Teste de Particionamento de pH**
* **Descrição sucinta do teste:** Teste da interface e da API de registro de dados (RF-02). Inserção de valores de pH com particionamento de equivalência inválido: pH negativo (-1), pH = 0 (borda), pH = 14 (borda), pH > 14 (15). O formulário/API deve bloquear os valores inválidos.
* **Modo de falha controlado:** [F06] Dados de pH aceitos fora do intervalo [0, 14].

**7. Teste de Borda do Gatilho de pH**
* **Descrição sucinta do teste:** Aplicação de Análise de Valor Limite na lógica de alerta (RN-004). Inserção de pH = 6,0 (borda segura, sem alerta) e pH = 5,9 (borda crítica, deve disparar alerta). O teste valida que o gatilho funciona exatamente na transição.
* **Modo de falha controlado:** [F07] Alerta não gerado quando pH ultrapassa 9,5 (e abaixo de 6,0).

**8. Teste de Ausência de Alerta com Dados Normais**
* **Descrição sucinta do teste:** Inserção de dados hídricos completamente dentro da normalidade (pH 7,2; turbidez 5 NTU; coliformes 0). Verificação de que nenhuma notificação push ou alerta é disparado pelo sistema (RF-05, RN-004).
* **Modo de falha controlado:** [F08] Alerta gerado com parâmetros normais.

**9. Teste de Particionamento de Turbidez**
* **Descrição sucinta do teste:** Teste da API de registro com valores de turbidez particionados: turbidez negativa (-5), turbidez = 0 (mínimo válido), turbidez = 40 NTU (borda de alerta), turbidez = 41 NTU (acima do limite). O sistema deve rejeitar valores negativos e disparar alerta acima de 40 NTU.
* **Modo de falha controlado:** [F09] Turbidez aceita valores negativos.

**10. Teste de Particionamento de Coliformes**
* **Descrição sucinta do teste:** Teste da API com valores de coliformes: valor negativo (-1), 0 UFC/100ml (seguro), 0,5 UFC/100ml (borda, deve disparar alerta), 100 UFC/100ml (claramente contaminado). O sistema deve rejeitar negativos e disparar alerta para qualquer valor > 0.
* **Modo de falha controlado:** [F10] Coliformes aceita valor negativo.

---

### Ações de Controle (Notificações e Push)
>`Responsável: João Siqueira`

**11. Teste de Envio de Notificação Push Crítica**
* **Descrição sucinta do teste:** Após inserção de dados críticos (pH = 5,0), verificação de que a notificação push foi efetivamente enviada ao serviço de mensageria (FCM/APNS) e recebida pelo dispositivo do usuário em até 30 segundos (RNF-013, RF-04).
* **Modo de falha controlado:** [F11] Push notification não enviada em alerta crítico.

**12. Teste de Conteúdo dos Alertas**
* **Descrição sucinta do teste:** Verificação do payload do alerta gerado para confirmar que contém o campo `recomendacao` preenchido com orientação de uso (ex: "Água imprópria para consumo") conforme RF-06.
* **Modo de falha controlado:** [F12] Alerta gerado sem recomendação de uso.

**13. Teste de Desempenho e Carga da API**
* **Descrição sucinta do teste:** Simulação de carga com JMeter: 100 usuários simultâneos realizando consultas de qualidade da água. Medição do percentil 95 de latência — deve ser ≤ 2 segundos (RNF-001).
* **Modo de falha controlado:** [F13] Tempo de resposta da API > 2 segundos.

---

### Ações de Controle (Reporte de Saneamento)
>`Responsável: Luan Ferreira`

**14. Teste de Obrigatoriedade de Localização GPS**
* **Descrição sucinta do teste:** Tentativa de envio de reporte de saneamento sem localização via GPS e sem seleção manual no mapa. O sistema deve bloquear a submissão e exibir mensagem de erro (RN-007, RF-21).
* **Modo de falha controlado:** [F14] Reporte enviado sem localização.

**15. Teste de Validação de Descrição do Reporte**
* **Descrição sucinta do teste:** Envio do formulário de reporte com o campo `descricao` vazio. O sistema deve solicitar complementação (RF-23) e não persistir a ocorrência.
* **Modo de falha controlado:** [F15] Formulário enviado com descrição vazia.

**16. Teste de Concorrência no Registro de Reporte**
* **Descrição sucinta do teste:** Clique duplo rápido no botão "Enviar Reporte" em menos de 500ms. O sistema deve registrar apenas 1 ocorrência, utilizando debounce no frontend ou idempotência no endpoint POST de ocorrências (RF-24).
* **Modo de falha controlado:** [F16] Clique duplo cria 2 ocorrências idênticas.

---

### Ações de Controle (Histórico e Consulta Regional)
>`Responsável: Victor Davidson`

**17. Teste de Ordenação do Histórico**
* **Descrição sucinta do teste:** Inserção de registros históricos com timestamps distintos (hoje, ontem, semana passada). Verificação de que a listagem retornada pela API e exibida na interface está em ordem decrescente (mais recente primeiro), conforme RN-005 e RF-09.
* **Modo de falha controlado:** [F17] Histórico exibido em ordem aleatória.

**18. Teste de Exibição de Região Indisponível**
* **Descrição sucinta do teste:** Consulta de uma região sem nenhum dado cadastrado. O sistema deve exibir a mensagem "Não existem dados registrados para esta localidade" e marcar a região como "Indisponível" no mapa (RF-10, RN-002).
* **Modo de falha controlado:** [F18] Região sem dados exibe tela em branco.

**19. Teste de Isolamento de Dados por Região**
* **Descrição sucinta do teste:** Consulta de qualidade da água para a região A enquanto a região B tem dados distintos. Verificação de que os dados retornados correspondem exclusivamente à região A, com filtro de ID_Regiao correto na query (RF-08, RN-002).
* **Modo de falha controlado:** [F19] Dados de outra região exibidos.

---

### Ações de Controle (Cadastro e Conta)
>`Responsável: Victor Madeu`

**20. Teste de Anonimização na Exclusão de Conta**
* **Descrição sucinta do teste:** Exclusão de uma conta que possui reportes de saneamento associados. Verificação de que os dados pessoais (nome, e-mail, CPF/CNPJ, senha) foram apagados do banco e que os reportes foram mantidos com o campo `id_usuario` nulo (anonimizado), conforme RN-008 e a LGPD.
* **Modo de falha controlado:** [F20] Exclusão não anonimiza reportes de saneamento.
