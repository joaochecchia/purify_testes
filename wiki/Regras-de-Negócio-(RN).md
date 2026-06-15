> Esta seção estabelece e detalha as Regras de Negócio (RN) que regem a lógica operacional, as políticas e os cálculos fundamentais do sistema **Purify**. As regras refletem os requisitos técnicos, normativos e legais que o sistema deve respeitar para garantir a qualidade, a segurança e a integridade das informações hídricas disponibilizadas aos usuários.

---

### RN-001 – Atualidade dos Dados (Freshness)

* **Descrição:** O sistema deve priorizar e exibir o registro com a data/hora de coleta mais recente para uma determinada região. Registros antigos devem ser movidos automaticamente para o módulo de histórico.
* **Fonte/Autoridade:** Manual de Requisitos de Interface v1.0
* **Impacto:** UC-04 (Consultar Qualidade da Água); RF-07; RF-09; RF-14

### RN-002 – Restrição de Consulta por Disponibilidade

* **Descrição:** A funcionalidade de consulta só deve permitir a seleção de regiões que possuam ao menos um registro de dado (qualidade ou saneamento) no banco de dados. Regiões sem dados devem aparecer como "Indisponíveis" no mapa.
* **Fonte/Autoridade:** Especificação de Arquitetura de Dados
* **Impacto:** UC-04 (Consultar Qualidade da Água); RF-08; RF-15

### RN-003 – Controle de Acesso para Escrita

* **Descrição:** Operações de criação, edição ou exclusão de dados técnicos (qualidade e saneamento) são restritas a usuários com perfis autenticados de "ONG" ou "Governante". O sistema deve validar o token de autorização antes de cada transação de escrita.
* **Fonte/Autoridade:** Matriz de Responsabilidades do Projeto
* **Impacto:** UC-07 (Registrar Dados Técnicos); RF-19

### RN-004 – Gatilho de Alerta Crítico

* **Descrição:** O disparo de alertas e notificações só deve ocorrer quando os indicadores validados de qualidade da água saírem dos limites de segurança: **pH < 6,0 ou > 9,5**; **turbidez > 40 NTU**; **coliformes > 0 UFC/100ml**. Não devem ser gerados alertas para variações dentro da normalidade.
* **Fonte/Autoridade:** Portaria GM/MS nº 888/2021 — Ministério da Saúde
* **Impacto:** UC-05 (Gerar Alerta de Risco); RF-03; RF-05

### RN-005 – Ordenação Cronológica de Histórico

* **Descrição:** Ao recuperar dados históricos, o sistema deve aplicar obrigatoriamente um filtro de ordenação decrescente (do mais recente para o mais antigo) baseado no timestamp da coleta.
* **Fonte/Autoridade:** Requisito de Usabilidade — Análise Temporal
* **Impacto:** RF-07; RF-09

### RN-006 – Identificação Única de Usuário

* **Descrição:** Cada conta no sistema deve ser vinculada a um identificador único universal (UUID) gerado no momento do cadastro, atrelado obrigatoriamente a um CPF ou CNPJ válido (com validação matemática dos dígitos verificadores) e não duplicado.
* **Fonte/Autoridade:** LGPD e Regras de Integridade de Banco de Dados
* **Impacto:** UC-01 (Criar Conta); RF-13

### RN-007 – Vínculo Geográfico de Ocorrências

* **Descrição:** É mandatório que todo reporte de problema de saneamento contenha metadados de localização (latitude e longitude) capturados via GPS do dispositivo ou seleção manual precisa no mapa. O sistema deve impedir o registro de problemas sem informação de local.
* **Fonte/Autoridade:** Procedimento Operacional de Fiscalização
* **Impacto:** UC-06 (Reportar Problema); RF-21

### RN-008 – Anonimização de Dados para Exclusão

* **Descrição:** Ao excluir uma conta, os dados pessoais sensíveis (nome, e-mail, senha, documentos) devem ser apagados definitivamente. Os reportes de problemas de saneamento vinculados a esse usuário devem ser mantidos de forma anonimizada para preservação do histórico estatístico da região.
* **Fonte/Autoridade:** LGPD — Lei nº 13.709/2018
* **Impacto:** UC-08 (Excluir Conta)

---

## Notas de Versão

* **v1.0 (16/03/2026):** Criação do documento e definição das 8 regras de negócio.
* **v1.1 (02/04/2026):** Revisão das RN-004 conforme Portaria GM/MS nº 888/2021 e ajuste de impactos.
