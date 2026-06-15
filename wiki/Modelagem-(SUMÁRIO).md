>Esta página serve como índice para todas as modelagens de Casos de Teste (Testes de Aceite e Testes de Controle de Falha) do sistema **Purify**. Os testes foram elaborados utilizando as técnicas de **Partição de Equivalência (EP)**, **Análise de Valor de Borda (BVA2)** e **Tabela de Decisão (DT)**.

*Clique nos links abaixo para acessar a modelagem individual de cada teste.*

## 👨‍💻 Autenticação e Segurança
`Responsável: João Gabriel Brito Checchia`
* [[TC‐EP1: Particionamento de Autenticação de Usuário]]
* [[TC‐EP2: Particionamento de Perfil de Acesso (RBAC)]]
* [[TC‐BVA1: Bloqueio de Força Bruta no Login]]
* [[TC‐BVA2: Limite de Expiração de Token JWT]]
* [[TC‐DT1: Lógica de Permissão de Acesso por Perfil]]
* [[TC‐DT2: Recuperação de Senha Segura]]

## 👨‍💻 Qualidade da Água e Alertas
`Responsável: João Gabriel Brito Checchia`
* [[TC‐EP1: Particionamento de Parâmetros de pH]]
* [[TC‐EP2: Particionamento de Turbidez]]
* [[TC‐BVA1: Limites de pH para Alerta]]
* [[TC‐BVA2: Limites de Coliformes para Alerta]]
* [[TC‐DT1: Lógica de Geração de Alertas de Risco]]
* [[TC‐DT2: Validação de Dados Técnicos de Qualidade]]

## 👨‍💻 Notificações e Push
`Responsável: João Gabriel Brito Checchia`
* [[TC‐EP1: Particionamento de Níveis de Alerta]]
* [[TC‐EP2: Canais de Notificação Push]]
* [[TC‐BVA1: Disparo de Alerta por Turbidez]]
* [[TC‐BVA2: Limite de Atraso de Notificação Push]]
* [[TC‐DT1: Lógica de Notificação por Gravidade do Alerta]]
* [[TC‐DT2: Conteúdo e Recomendações dos Alertas]]

## 👨‍💻 Reporte de Saneamento
`Responsável: João Gabriel Brito Checchia`
* [[TC‐EP1: Particionamento de Tipo de Problema de Saneamento]]
* [[TC‐EP2: Estado de Localização GPS]]
* [[TC‐BVA1: Limite de Caracteres na Descrição do Problema]]
* [[TC‐BVA2: Precisão da Localização GPS]]
* [[TC‐DT1: Combinação de Tipo de Problema e Localização]]
* [[TC‐DT2: Validação do Reporte de Ocorrência]]

## 👨‍💻 Histórico e Consulta Regional
`Responsável: João Gabriel Brito Checchia`
* [[TC‐EP1: Particionamento de Filtros de Histórico]]
* [[TC‐EP2: Particionamento de Região de Consulta]]
* [[TC‐BVA1: Limite de Período de Histórico]]
* [[TC‐BVA2: Paginação de Dados Históricos]]
* [[TC‐DT1: Ordenação Cronológica do Histórico]]
* [[TC‐DT2: Disponibilidade Regional de Dados]]

## 👨‍💻 Cadastro e Exclusão de Conta
`Responsável: João Gabriel Brito Checchia`
* [[TC‐EP1: Particionamento de CPF e CNPJ]]
* [[TC‐EP2: Particionamento de Tipo de Perfil]]
* [[TC‐BVA1: Limites de Validação de Dados de Cadastro]]
* [[TC‐BVA2: Validação de Força de Senha]]
* [[TC‐DT1: Unicidade de Cadastro]]
* [[TC‐DT2: Anonimização na Exclusão de Conta]]
