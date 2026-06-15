>## 1. Introdução
>Esta página apresenta a **Matriz de Rastreabilidade** do sistema **Purify**. O objetivo deste artefato é garantir que todos os Requisitos (R) definidos na documentação e todos os Modos de Falha (F) identificados no FMEA possuam cobertura adequada por meio de Testes de Aceite (T) e Testes de Controle de Falha (TF). A matriz documenta a cobertura de testes realizada por **João Gabriel Brito Checchia**.

### Legenda de Estados dos Testes:
* **P:** Pendente (Não iniciado)
* **C:** Em construção (Desenvolvimento do script/cenário)
* **I:** Implementado (Pronto para execução)
* **A:** Aprovado (Executado com sucesso)
* **R:** Reprovado (Executado, mas apresentou falha/bug)
* **-:** Não se aplica (Sem relação com o teste na célula)

---

## 2. Índices de Mapeamento

### 2.1. Requisitos (R1 a R25)

| Índice | Ref. Original | Descrição do Requisito |
| :--- | :--- | :--- |
| **R1** | RF-01 | Registrar dados de qualidade da água |
| **R2** | RF-02 | Validar dados de qualidade da água |
| **R3** | RF-03 | Gerar alertas de risco |
| **R4** | RF-04 | Exibir alertas ao usuário |
| **R5** | RF-05 | Não gerar alertas desnecessários |
| **R6** | RF-06 | Incluir recomendações nos alertas |
| **R7** | RF-07 | Visualizar histórico de dados |
| **R8** | RF-08 | Filtrar histórico por região |
| **R9** | RF-09 | Exibir histórico em ordem cronológica |
| **R10** | RF-10 | Informar ausência de histórico |
| **R11** | RF-11 | Cadastrar usuários |
| **R12** | RF-12 | Validar dados de cadastro |
| **R13** | RF-13 | Garantir unicidade de usuário |
| **R14** | RF-14 | Consultar condições de saneamento |
| **R15** | RF-15 | Selecionar região para consulta de saneamento |
| **R16** | RF-16 | Informar ausência de dados de saneamento |
| **R17** | RF-17 | Registrar dados de saneamento |
| **R18** | RF-18 | Validar dados de saneamento |
| **R19** | RF-19 | Restringir registro a usuários autorizados (RBAC) |
| **R20** | RF-20 | Reportar problemas de saneamento |
| **R21** | RF-21 | Informar localização do problema (GPS obrigatório) |
| **R22** | RF-22 | Descrever problema de saneamento |
| **R23** | RF-23 | Validar informações do problema |
| **R24** | RF-24 | Registrar ocorrência de problema |
| **R25** | RF-25 | Disponibilizar dados para consulta pública |

### 2.2. Modos de Falha (F1 a F20)

Os índices de **F1 a F20** referem-se à numeração exata documentada na tabela FMEA presente na página *Análise e Controle de Risco de Produto (FMEA)*.

---

## 3. Relação de Testes (T e TF)

### Autenticação e Segurança
`Responsável: João Gabriel Brito Checchia`

* **Testes de Aceite (T):**
  * **T1:** Validar login com e-mail e senha corretos.
  * **T2:** Bloquear acesso com credenciais inválidas.
  * **T3:** Validar acesso restrito por perfil (Morador vs ONG/Governante).
  * **T4:** Confirmar expiração de token JWT após prazo configurado.
  * **T5:** Verificar bloqueio de conta após tentativas excessivas de login.
* **Testes de Controle de Falha (TF):**
  * **TF1:** Teste de Limite de Requisições contra Brute Force.
  * **TF2:** Teste de Isolamento de Perfil (RBAC no backend).
  * **TF3:** Teste de Validade e Expiração de Token JWT.
  * **TF4:** Teste de Duplicidade de Cadastro.
  * **TF5:** Teste Estático de Criptografia de Senhas.

### Qualidade da Água e Alertas
`Responsável: João Gabriel Brito`

* **Testes de Aceite (T):**
  * **T6:** Validar registro de dados hídricos por usuário técnico (pH, turbidez, coliformes).
  * **T7:** Confirmar rejeição de dados inválidos (pH negativo, turbidez negativa).
  * **T8:** Validar geração de alerta quando pH < 6,0.
  * **T9:** Validar ausência de alerta com parâmetros dentro da normalidade.
  * **T10:** Confirmar que coliformes > 0 UFC/100ml gera alerta.
* **Testes de Controle de Falha (TF):**
  * **TF6:** Teste de Particionamento de pH.
  * **TF7:** Teste de Borda do Gatilho de pH.
  * **TF8:** Teste de Ausência de Alerta com Dados Normais.
  * **TF9:** Teste de Particionamento de Turbidez.
  * **TF10:** Teste de Particionamento de Coliformes.

### Notificações e Push
`Responsável: João Gabriel Brito Checchia`

* **Testes de Aceite (T):**
  * **T11:** Validar envio de push notification em alerta crítico.
  * **T12:** Confirmar que alerta contém recomendação de uso da água.
  * **T13:** Validar que overlay vermelho aparece no mapa em área crítica.
  * **T14:** Confirmar ausência de notificação em parâmetros normais.
  * **T15:** Validar tempo de chegada da notificação (≤ 30 segundos).
* **Testes de Controle de Falha (TF):**
  * **TF11:** Teste de Envio de Notificação Push Crítica.
  * **TF12:** Teste de Conteúdo dos Alertas.
  * **TF13:** Teste de Desempenho e Carga da API.
  * **TF14:** Teste de Alerta por Diferentes Parâmetros Críticos.
  * **TF15:** Teste de Combinação de Múltiplos Parâmetros Críticos.

### Reporte de Saneamento
`Responsável: João Gabriel Brito Checchia`

* **Testes de Aceite (T):**
  * **T16:** Validar reporte com localização GPS e descrição preenchidos.
  * **T17:** Confirmar bloqueio de reporte sem localização GPS.
  * **T18:** Confirmar bloqueio de reporte sem descrição.
  * **T19:** Validar associação do reporte ao usuário.
  * **T20:** Confirmar seleção de tipo de problema.
* **Testes de Controle de Falha (TF):**
  * **TF16:** Teste de Obrigatoriedade de Localização GPS.
  * **TF17:** Teste de Validação de Descrição do Reporte.
  * **TF18:** Teste de Concorrência no Registro de Reporte.
  * **TF19:** Teste de Tipo de Problema Válido.
  * **TF20:** Teste de Seleção Manual de Localização no Mapa.

### Histórico e Consulta Regional
`Responsável: João Gabriel Brito Checchia`

* **Testes de Aceite (T):**
  * **T21:** Validar exibição de histórico em ordem cronológica decrescente.
  * **T22:** Confirmar filtro de histórico por região.
  * **T23:** Validar mensagem de ausência de dados para região sem registros.
  * **T24:** Confirmar isolamento de dados entre regiões distintas.
  * **T25:** Validar paginação de dados históricos.
* **Testes de Controle de Falha (TF):**
  * **TF21:** Teste de Ordenação do Histórico.
  * **TF22:** Teste de Exibição de Região Indisponível.
  * **TF23:** Teste de Isolamento de Dados por Região.
  * **TF24:** Teste de Paginação de Histórico.
  * **TF25:** Teste de Filtro Combinado (Região + Período).

### Cadastro e Exclusão de Conta
`Responsável: João Gabriel Brito Checchia`

* **Testes de Aceite (T):**
  * **T26:** Validar cadastro com dados válidos (e-mail, CPF/CNPJ, senha forte).
  * **T27:** Confirmar rejeição de e-mail duplicado no cadastro.
  * **T28:** Validar que senha fraca bloqueia o cadastro.
  * **T29:** Confirmar exclusão de conta com anonimização de reportes.
  * **T30:** Validar que CPF/CNPJ inválido (dígitos verificadores errados) bloqueia cadastro.
* **Testes de Controle de Falha (TF):**
  * **TF26:** Teste de Duplicidade de Cadastro.
  * **TF27:** Teste de Validação de Força de Senha.
  * **TF28:** Teste de Unicidade de CPF/CNPJ.
  * **TF29:** Teste de Anonimização na Exclusão de Conta.
  * **TF30:** Teste de Validação de Perfil no Cadastro.

---

## 4. Matriz de Rastreabilidade

| Teste | R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8 | R9 | R10 | R11 | R12 | R13 | R19 | R20 | R21 | R22 | R23 | R24 | F# |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| T1 / TF1 | - | - | - | - | - | - | - | - | - | - | A | - | - | - | - | - | - | - | - | F01 |
| T2 / TF2 | - | - | - | - | - | - | - | - | - | - | - | - | - | A | - | - | - | - | - | F02 |
| T3 / TF3 | - | - | - | - | - | - | - | - | - | - | - | - | - | A | - | - | - | - | - | F03 |
| T4 / TF4 | - | - | - | - | - | - | - | - | - | - | A | - | A | - | - | - | - | - | - | F04 |
| T6 / TF6 | A | A | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | F06 |
| T7 / TF7 | - | A | A | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | F07 |
| T8 / TF8 | - | A | - | - | A | - | - | - | - | - | - | - | - | - | - | - | - | - | - | F08 |
| T9 / TF9 | - | A | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | F09 |
| T16 / TF16 | - | - | - | - | - | - | - | - | - | - | - | - | - | - | A | A | - | - | A | F14 |
| T17 / TF17 | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | A | - | F15 |
| T21 / TF21 | - | - | - | - | - | - | A | - | A | - | - | - | - | - | - | - | - | - | - | F17 |
| T23 / TF22 | - | - | - | - | - | - | - | - | - | A | - | - | - | - | - | - | - | - | - | F18 |
| T24 / TF23 | - | - | - | - | - | - | - | A | - | - | - | - | - | - | - | - | - | - | - | F19 |
| T29 / TF29 | - | - | - | - | - | - | - | - | - | - | A | - | - | - | - | - | - | - | - | F20 |
