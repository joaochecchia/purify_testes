Nesta seção serão descritas as histórias de usuário, que descrevem as funcionalidades do sistema a partir da perspectiva dos usuários, identificando as principais ações que poderão ser realizadas para apoiar o monitoramento da qualidade da água e o reporte de problemas de saneamento. Elas representam as necessidades dos diferentes perfis de acesso e estão relacionadas às regras de negócio definidas para garantir o funcionamento adequado do sistema.

## Personas do Sistema

### Persona 01: Cláudia (Moradora)
* **Perfil:** Moradora do Distrito Federal que depende do abastecimento público de água. Não possui conhecimento técnico sobre parâmetros hídricos, mas se preocupa com a qualidade da água que sua família consome.
* **Dores:** Não tem como saber se a água da torneira é segura para beber. Já ouviu rumores sobre contaminação no bairro, mas nunca conseguiu informação oficial. Quer ser avisada antes de usar a água em situações de risco.
* **Objetivo no sistema:** Consultar em tempo real a qualidade da água de sua região, receber alertas quando houver risco e reportar problemas de saneamento que observa no bairro.

### Persona 02: Rafael (Técnico de ONG Ambiental)
* **Perfil:** Analista ambiental de uma ONG que monitora corpos d'água no Cerrado. Coleta amostras em campo e precisa registrar os dados em um sistema centralizado para que a população tenha acesso.
* **Dores:** O processo atual é manual e burocrático — ele preenche planilhas que ninguém consulta. Precisa de uma plataforma que publique os dados em tempo real e gere alertas automáticos para autoridades.
* **Objetivo no sistema:** Registrar dados técnicos de pH, turbidez e coliformes por região, com validação automática e disparo de alertas para os moradores afetados.

### Persona 03: Dra. Fernanda (Gestora Governamental)
* **Perfil:** Coordenadora de saneamento da Secretaria de Meio Ambiente do DF. Responsável por acionar equipes de campo e emitir boletins de saúde pública quando há risco de contaminação.
* **Dores:** Recebe informações dispersas de diferentes fontes e demoram muito para chegar. Precisa de um painel centralizado com dados em tempo real para tomar decisões rápidas.
* **Objetivo no sistema:** Visualizar o mapa de qualidade da água, receber alertas críticos imediatos e acessar histórico de dados para fundamentar decisões de política pública.

## Histórias de Usuário

### **HU01 - Autenticação no Sistema**
* **Como**Cláudia (Moradora) ou Rafael (Técnico)
* **Quero** realizar login com minhas credenciais ou via SSO (Google/Apple)
* **Para** acessar as funcionalidades personalizadas do sistema de forma segura.

REFERÊNCIA RN: RN-003, RN-006

### **HU02 - Cadastrar Conta no Sistema**
* **Como** novo usuário
* **Quero** criar uma conta informando meus dados pessoais e tipo de perfil
* **Para** acessar o sistema e suas funcionalidades de acordo com meu perfil.

REFERÊNCIA RN: RN-006

### **HU03 - Consultar a Qualidade da Água**
* **Como**Cláudia (Moradora)
* **Quero** visualizar os indicadores de qualidade da água da minha região em tempo real
* **Para** saber se a água é segura para consumo e uso doméstico.

REFERÊNCIA RN: RN-001 / RN-002 / RN-005

### **HU04 - Receber Alertas de Risco Hídrico**
* **Como**Cláudia (Moradora) ou Dra. Fernanda (Gestora)
* **Quero** ser notificada automaticamente quando a qualidade da água da minha região atingir níveis críticos
* **Para** tomar medidas preventivas com antecedência e evitar riscos à saúde.

REFERÊNCIA RN: RN-004

### **HU05 - Consultar Histórico de Dados**
* **Como**Cláudia (Moradora) ou Dra. Fernanda (Gestora)
* **Quero** visualizar o histórico de indicadores de qualidade da água de uma região em ordem cronológica
* **Para** acompanhar a evolução da qualidade ao longo do tempo e identificar tendências.

REFERÊNCIA RN: RN-001 / RN-005

### **HU06 - Registrar Dados Técnicos de Qualidade**
* **Como**Rafael (Técnico de ONG)
* **Quero** inserir no sistema os indicadores oficiais de qualidade da água coletados em campo
* **Para** manter a base de dados atualizada e disparar alertas automáticos quando necessário.

REFERÊNCIA RN: RN-003 / RN-004

### **HU07 - Consultar Dados de Saneamento**
* **Como**Cláudia (Moradora)
* **Quero** visualizar informações sobre cobertura de água e esgoto da minha região
* **Para** entender a infraestrutura de saneamento disponível e tomar decisões de moradia e saúde.

REFERÊNCIA RN: RN-002

### **HU08 - Reportar Problema de Saneamento**
* **Como**Cláudia (Moradora)
* **Quero** registrar um problema de saneamento que identifiquei no meu bairro (vazamento, esgoto aberto, falta de coleta)
* **Para** que autoridades e ONGs tomem ciência e possam agir rapidamente.

REFERÊNCIA RN: RN-007

### **HU09 - Excluir Minha Conta**
* **Como** usuário cadastrado
* **Quero** solicitar a exclusão permanente da minha conta e dos meus dados pessoais
* **Para** exercer meu direito à privacidade em conformidade com a LGPD.

REFERÊNCIA RN: RN-008
