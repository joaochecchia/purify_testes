Os requisitos funcionais descrevem as funcionalidades que o sistema **Purify** deve oferecer para monitoramento da qualidade da água, geração de alertas e gestão de ocorrências de saneamento.

---

### RF-01 — Registrar Dados de Qualidade da Água

O sistema deve permitir que o usuário técnico informe a região e insira indicadores de qualidade da água (pH, turbidez e coliformes), validando os dados e armazenando-os no histórico da região.

**Classificação:** Funcional
**Referência:** HU06, RN-003, RN-004

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Registro de dados técnicos com sucesso
  Given que o usuário está autenticado com perfil ONG ou Governante
  When ele informa pH 7.2, turbidez 2 NTU e coliformes 0 para uma região
  Then o sistema deve armazenar os dados no histórico da região
  And acionar a rotina de verificação de alertas
```

```gherkin
Scenario: Bloqueio de registro por perfil não autorizado
  Given que o usuário está autenticado com perfil Morador
  When ele tenta acessar a tela de inserção técnica de dados
  Then o sistema deve negar o acesso
  And exibir a mensagem "Acesso negado: Perfil não autorizado para registro técnico"
```

---

### RF-02 — Validar Dados de Qualidade da Água

O sistema deve verificar a consistência dos dados inseridos e solicitar correção caso estejam inválidos ou fora dos padrões aceitáveis (pH entre 0 e 14; turbidez ≥ 0 NTU; coliformes ≥ 0 UFC/100ml).

**Classificação:** Funcional
**Referência:** HU06, RN-004

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Dados inválidos — pH fora do intervalo
  Given que o usuário insere pH igual a -2
  When clica em "Salvar Registro"
  Then o sistema deve exibir "Valor de pH inválido. Informe um valor entre 0 e 14"
  And o formulário não deve ser submetido
```

---

### RF-03 — Gerar Alertas de Risco

O sistema deve analisar automaticamente os dados de qualidade da água e gerar alertas quando os indicadores ultrapassarem os limites seguros definidos em RN-004.

**Classificação:** Funcional
**Referência:** HU04, RN-004

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Geração de alerta por pH crítico
  Given que dados com pH 5.8 foram inseridos para uma região
  When o sistema executa a rotina de verificação
  Then deve gerar um alerta de risco para aquela região
  And adicionar uma camada vermelha (overlay) sobre a área no mapa
```

---

### RF-04 — Exibir Alertas ao Usuário

Permitir que o usuário visualize alertas de risco por meio da interface ou notificações push.

**Classificação:** Funcional
**Referência:** HU04, RN-004

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Exibição de alerta in-app por geolocalização
  Given que o usuário está com o app aberto e o GPS ativado
  When o GPS indica que entrou no raio geográfico de uma área crítica
  Then o aplicativo deve exibir imediatamente um pop-up de atenção e risco
```

---

### RF-05 — Não Gerar Alertas Desnecessários

O sistema não deve gerar alertas quando os indicadores estiverem dentro dos níveis normais.

**Classificação:** Funcional
**Referência:** RN-004

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Ausência de alerta com parâmetros normais
  Given que dados com pH 7.2, turbidez 5 NTU e coliformes 0 foram inseridos
  When o sistema executa a rotina de verificação
  Then nenhum alerta deve ser gerado
  And apenas o histórico deve ser atualizado
```

---

### RF-06 — Incluir Recomendações nos Alertas

Os alertas gerados devem conter recomendações de uso ou restrições da água.

**Classificação:** Funcional
**Referência:** HU04, RN-004

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Alerta com recomendação de uso
  Given que um alerta foi gerado por coliformes > 0 UFC/100ml
  When o usuário recebe a notificação push
  Then a mensagem deve conter uma recomendação como "Água imprópria para consumo"
```

---

### RF-07 — Visualizar Histórico de Dados

Permitir que usuários consultem o histórico dos indicadores de qualidade da água de uma região.

**Classificação:** Funcional
**Referência:** HU05, RN-001, RN-005

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Visualização do histórico de uma região
  Given que existem registros históricos para uma região
  When o usuário seleciona a aba "Histórico" e escolhe a região e o período
  Then o sistema deve exibir os dados ordenados do mais recente ao mais antigo
```

---

### RF-08 — Filtrar Histórico por Região

Permitir que o usuário selecione uma região específica para visualizar os dados históricos.

**Classificação:** Funcional
**Referência:** HU05, RN-002

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Filtro de histórico por região
  Given que existem dados históricos de múltiplas regiões
  When o usuário seleciona a região "Taguatinga"
  Then o sistema deve exibir apenas os dados históricos de Taguatinga
```

---

### RF-09 — Exibir Histórico em Ordem Cronológica

O sistema deve apresentar os dados históricos organizados em ordem temporal decrescente (mais recente primeiro).

**Classificação:** Funcional
**Referência:** HU05, RN-005

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Ordenação cronológica do histórico
  Given que existem registros de datas distintas para uma região
  When o histórico é exibido
  Then o registro mais recente deve aparecer no topo da lista
```

---

### RF-10 — Informar Ausência de Histórico

O sistema deve informar quando não existirem dados registrados para a região selecionada.

**Classificação:** Funcional
**Referência:** HU03, RN-002

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Região sem dados registrados
  Given que o usuário seleciona uma região sem registros históricos
  When o dashboard é carregado
  Then o sistema deve exibir a mensagem "Não existem dados registrados para esta localidade"
  And deve sugerir que o usuário reporte a ausência de monitoramento
```

---

### RF-11 — Cadastrar Usuários

Permitir que novos usuários realizem cadastro informando dados pessoais e tipo de perfil (Morador ou ONG/Governante).

**Classificação:** Funcional
**Referência:** HU02, RN-006

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Cadastro com dados válidos
  Given que o usuário preenche o formulário com e-mail e CPF/CNPJ válidos
  And cria uma senha com no mínimo 8 caracteres, 1 maiúscula e 1 número
  And aceita os Termos de Uso
  When clica em "Finalizar Cadastro"
  Then o sistema deve enviar um e-mail de confirmação
  And direcionar o usuário ao Dashboard principal
```

---

### RF-12 — Validar Dados de Cadastro

O sistema deve validar os dados informados no cadastro (e-mail, CPF/CNPJ, senha) e solicitar correções quando necessário.

**Classificação:** Funcional
**Referência:** HU02, RN-006

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Senha fraca no cadastro
  Given que o usuário informa uma senha com menos de 8 caracteres
  When clica em "Finalizar Cadastro"
  Then o sistema deve exibir "A senha deve ter no mínimo 8 caracteres, 1 maiúscula e 1 número"
```

---

### RF-13 — Garantir Unicidade de Usuário

O sistema deve impedir o cadastro de usuários com e-mail ou CPF/CNPJ já existentes no banco de dados.

**Classificação:** Funcional
**Referência:** HU02, RN-006

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: E-mail duplicado no cadastro
  Given que o usuário informa um e-mail já cadastrado no sistema
  When clica em "Finalizar Cadastro"
  Then o sistema deve exibir "E-mail já cadastrado. Faça login ou recupere sua senha."
  And o formulário não deve ser submetido
```

---

### RF-14 — Consultar Condições de Saneamento

Permitir que usuários visualizem informações sobre saneamento básico (cobertura de água e esgoto) de uma região.

**Classificação:** Funcional
**Referência:** HU07, RN-001, RN-002

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Consulta de saneamento com dados disponíveis
  Given que existem dados de saneamento para uma região selecionada
  When o usuário acessa a tela de saneamento
  Then o sistema deve exibir a cobertura de água e esgoto da região
```

---

### RF-15 — Selecionar Região para Consulta de Saneamento

Permitir que o usuário escolha a região desejada para consulta de dados de saneamento.

**Classificação:** Funcional
**Referência:** HU07, RN-002

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Seleção de região para consulta
  Given que o usuário está na tela de saneamento
  When digita 3 ou mais caracteres de um endereço ou CEP no campo de pesquisa
  Then o sistema deve sugerir uma lista de endereços correspondentes em tempo real
```

---

### RF-16 — Informar Ausência de Dados de Saneamento

O sistema deve informar quando não houver dados cadastrados sobre saneamento para a região.

**Classificação:** Funcional
**Referência:** HU07, RN-002

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Região sem dados de saneamento
  Given que o usuário seleciona uma região sem dados de saneamento
  When a tela é carregada
  Then o sistema deve exibir "Não há dados de saneamento para esta região"
```

---

### RF-17 — Registrar Dados de Saneamento

Permitir que usuários autorizados (ONG/Governante) registrem informações técnicas sobre saneamento básico de uma região.

**Classificação:** Funcional
**Referência:** HU06, RN-003

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Registro de dados de saneamento com sucesso
  Given que o usuário está autenticado com perfil ONG ou Governante
  When ele insere a cobertura de água e esgoto válidas para uma região
  Then o sistema deve salvar os dados e confirmar o registro
```

---

### RF-18 — Validar Dados de Saneamento

O sistema deve validar os dados inseridos no registro de saneamento e solicitar correções em caso de inconsistência.

**Classificação:** Funcional
**Referência:** HU06, RN-003

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Cobertura inválida no registro de saneamento
  Given que o usuário insere cobertura de água igual a 150%
  When clica em "Salvar Registro"
  Then o sistema deve exibir "Valor de cobertura inválido. Informe um percentual entre 0 e 100"
```

---

### RF-19 — Restringir Registro a Usuários Autorizados

Apenas usuários com perfis autenticados de ONG ou Governante devem poder registrar dados técnicos.

**Classificação:** Funcional
**Referência:** HU06, RN-003

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Acesso negado a Morador para inserção técnica
  Given que o usuário está autenticado com perfil Morador
  When tenta acessar a rota de registro técnico
  Then o sistema deve retornar HTTP 403 Forbidden
  And exibir "Acesso negado: Perfil não autorizado"
```

---

### RF-20 — Reportar Problemas de Saneamento

Permitir que moradores autenticados registrem problemas relacionados ao saneamento básico.

**Classificação:** Funcional
**Referência:** HU08, RN-007

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Reporte de vazamento com sucesso
  Given que o usuário está logado com perfil Morador
  And selecionou o tipo de problema "Vazamento"
  And a localização via GPS está anexada ao formulário
  When clica em "Enviar Reporte"
  Then o sistema deve criar um registro vinculado ao perfil do usuário
  And exibir "Reporte enviado com sucesso!"
```

---

### RF-21 — Informar Localização do Problema

O sistema deve exigir que o usuário informe a localização do problema reportado.

**Classificação:** Funcional
**Referência:** HU08, RN-007

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Bloqueio por ausência de localização
  Given que o usuário tenta reportar um problema
  And não forneceu acesso ao GPS nem selecionou um local no mapa
  When clica em "Enviar Reporte"
  Then o sistema deve bloquear a requisição
  And exibir "Localização obrigatória para reportar ocorrência"
```

---

### RF-22 — Descrever Problema de Saneamento

Permitir que o usuário descreva a natureza do problema e selecione o tipo de ocorrência.

**Classificação:** Funcional
**Referência:** HU08, RN-007

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Seleção de tipo de problema e descrição
  Given que o usuário está no formulário de reporte
  When seleciona o tipo "Esgoto aberto" e preenche a descrição
  Then o sistema deve aceitar as informações e habilitar o botão de envio
```

---

### RF-23 — Validar Informações do Problema

O sistema deve validar se as informações fornecidas são suficientes e solicitar complementação se necessário.

**Classificação:** Funcional
**Referência:** HU08, RN-007

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Reporte com descrição vazia
  Given que o usuário não preencheu o campo de descrição do problema
  When tenta enviar o reporte
  Then o sistema deve solicitar complementação
  And exibir "Por favor, descreva o problema antes de enviar"
```

---

### RF-24 — Registrar Ocorrência de Problema

O sistema deve armazenar o problema reportado e associá-lo ao usuário que realizou o registro.

**Classificação:** Funcional
**Referência:** HU08, RN-007

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Associação do reporte ao usuário
  Given que o reporte foi enviado com sucesso
  When o usuário acessa seu histórico de reportes
  Then deve visualizar a ocorrência registrada com sua identificação
```

---

### RF-25 — Disponibilizar Dados para Consulta Pública

Os dados registrados (qualidade da água, saneamento e alertas) devem estar disponíveis para consulta por qualquer usuário autenticado.

**Classificação:** Funcional
**Referência:** HU03, HU05, HU07

#### Critério de Aceitação (Gherkin)

```gherkin
Scenario: Consulta pública de dados por usuário autenticado
  Given que o usuário está autenticado no sistema
  When acessa a seção de dados de qualidade, saneamento ou alertas
  Then o sistema deve exibir os dados disponíveis para aquela região
```

---
