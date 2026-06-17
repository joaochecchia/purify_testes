# Plano de Aplicação BDD

## Introdução

Este plano descreve como a abordagem BDD (Behavior Driven Development) será aplicada no desenvolvimento do sistema **Purify**, com o objetivo de garantir que as funcionalidades sejam construídas com base no comportamento esperado pelos usuários. O BDD será utilizado para definir critérios de aceitação claros, melhorar a comunicação entre os membros da equipe e garantir que o sistema atenda às necessidades reais dos usuários que dependem das informações de qualidade da água.

# 1. Objetivo do uso do BDD

O uso do BDD neste projeto tem como objetivos principais:

- Definir claramente o comportamento esperado do sistema de monitoramento hídrico
- Garantir que os requisitos sejam compreendidos por toda a equipe (desenvolvedores, testadores e stakeholders)
- Facilitar a validação das funcionalidades críticas de alerta e monitoramento
- Reduzir ambiguidades nos requisitos, especialmente nos limites de parâmetros hídricos (RN-004)
- Permitir que testes sejam escritos em linguagem natural acessível a todos os perfis de usuário

# 2. Abordagem adotada

O projeto utilizará a abordagem BDD baseada em:

- Definição de critérios de aceitação por história de usuário
- Escrita de cenários utilizando o padrão Gherkin
- Estrutura:
 - **Dado (Given)**
 - **Quando (When)**
 - **Então (Then)**

Os cenários serão utilizados como base para testes e validação das funcionalidades.

# 3. Processo de aplicação do BDD

O BDD será aplicado seguindo as etapas abaixo:

1. Identificação da funcionalidade a partir da história de usuário
2. Definição dos critérios de aceitação
3. Escrita dos cenários em Gherkin
4. Implementação da funcionalidade
5. Execução dos testes baseados nos cenários
6. Validação com base no comportamento esperado

# 4. Funcionalidades do sistema e cenários BDD

## 4.1 Autenticação no Sistema

### Critério de aceitação

O sistema deve permitir que um usuário autenticado acesse o dashboard com sua localização e dados hídricos.

### Cenário BDD

```gherkin
Dado que o usuário possui uma conta cadastrada no sistema
Quando ele informa e-mail e senha corretos
Então o sistema deve permitir o acesso ao dashboard principal
```

## 4.2 Cadastro de Conta

### Critério de aceitação

O sistema deve permitir que novos usuários realizem cadastro com CPF/CNPJ válido, e-mail único e senha forte.

### Cenário BDD

```gherkin
Dado que o usuário está na tela de cadastro
Quando ele preenche e-mail, CPF válido e senha com no mínimo 8 caracteres
E clica em "Finalizar Cadastro"
Então o sistema deve criar a conta e enviar e-mail de confirmação
```

## 4.3 Consultar Qualidade da Água

### Critério de aceitação

O sistema deve exibir os indicadores de qualidade da água (pH, turbidez, IQA) com código de cores para a região selecionada.

### Cenário BDD

```gherkin
Dado que o usuário está autenticado e selecionou uma região com dados disponíveis
Quando o dashboard é carregado
Então o sistema deve exibir pH, turbidez e IQA com indicadores coloridos
E mostrar a data e hora da última coleta
```

## 4.4 Geração de Alerta de Risco

### Critério de aceitação

O sistema deve gerar alerta automaticamente quando os indicadores ultrapassam os limites da Portaria GM/MS nº 888/2021.

### Cenário BDD

```gherkin
Dado que dados de qualidade da água foram inseridos na API
Quando o pH registrado é 5.5 (abaixo do limite seguro de 6.0)
Então o sistema deve gerar um alerta de risco para a região
E enviar notificação push para os moradores afetados
E exibir uma recomendação de uso da água
```

## 4.5 Ausência de Alerta com Dados Normais

### Critério de aceitação

O sistema não deve gerar alertas quando os parâmetros estão dentro dos limites seguros.

### Cenário BDD

```gherkin
Dado que dados com pH 7.2, turbidez 5 NTU e coliformes 0 foram inseridos
Quando o sistema processa a validação
Então nenhum alerta deve ser gerado
E apenas o histórico deve ser atualizado
```

## 4.6 Reporte de Problema de Saneamento

### Critério de aceitação

O sistema deve exigir localização GPS obrigatória ao registrar um problema de saneamento.

### Cenário BDD

```gherkin
Dado que o usuário Morador está autenticado
E selecionou o tipo de problema "Vazamento"
E forneceu localização via GPS
Quando clica em "Enviar Reporte"
Então o sistema deve registrar a ocorrência vinculada ao usuário
E exibir confirmação de envio
```

## 4.7 Bloqueio de Reporte sem Localização

### Critério de aceitação

O sistema deve bloquear a submissão de reporte sem localização geográfica.

### Cenário BDD

```gherkin
Dado que o usuário tenta enviar um reporte sem localização GPS
Quando clica em "Enviar Reporte"
Então o sistema deve exibir "Localização obrigatória para reportar ocorrência"
E não deve registrar a ocorrência
```

## 4.8 Visualizar Histórico Ordenado

### Critério de aceitação

O histórico deve ser exibido em ordem cronológica decrescente.

### Cenário BDD

```gherkin
Dado que existem registros históricos de diferentes datas para uma região
Quando o usuário acessa a aba "Histórico"
Então o registro mais recente deve aparecer no topo da lista
```

## 4.9 Exclusão de Conta com Anonimização

### Critério de aceitação

A exclusão de conta deve remover dados pessoais e anonimizar reportes vinculados.

### Cenário BDD

```gherkin
Dado que o usuário solicitou a exclusão da conta
E confirmou com dupla autenticação
Quando a exclusão é processada
Então os dados pessoais devem ser removidos do banco
E os reportes de saneamento devem ser mantidos de forma anonimizada
E o sistema deve exibir "Sua conta foi excluída com sucesso"
```
