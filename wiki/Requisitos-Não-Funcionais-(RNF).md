Esta seção define os Requisitos Não Funcionais (RNF) do sistema **Purify**, estabelecendo critérios de qualidade relacionados a desempenho, segurança, disponibilidade, usabilidade e manutenção da aplicação de monitoramento da qualidade da água.

## **RNF-001 – Desempenho: Tempo de Resposta**

* **Descrição:** O sistema deve processar e exibir os dados de qualidade da água em tempo real. O tempo de resposta da API não deve exceder 2 segundos para 95% das requisições, garantindo a eficácia do monitoramento contínuo.
* **Critério sugerido:** tempo médio de resposta inferior a 2 segundos para operações comuns.
* **Impacto:** Todos os RF e RN que envolvem consulta ou registro de dados.

## **RNF-002 – Usabilidade: Interface Intuitiva**

* **Descrição:** A interface do usuário deve ser intuitiva e de fácil navegação, permitindo que usuários com diferentes níveis de habilidade técnica (Moradores, ONGs, Governo) acessem e compreendam as informações de qualidade da água e alertas hídricos sem necessidade de treinamento.
* **Critério sugerido:** usuários devem navegar e realizar cadastros sem assistência externa em menos de 3 minutos. Pontuação SUS ≥ 68.
* **Impacto:** HU01, HU02, HU03, HU08.

## **RNF-003 – Disponibilidade: Monitoramento Contínuo**

* **Descrição:** O sistema deve garantir disponibilidade mínima de 99,5% (SLA) mensal, minimizando períodos de inatividade planejada ou não planejada. Nenhuma janela de manutenção deve ultrapassar 2 horas consecutivas.
* **Critério sugerido:** sistema fora do ar por no máximo ~3,6 horas acumuladas por mês.
* **Impacto:** Todos os RF e RN.

## **RNF-004 – Segurança: Proteção de Dados e Privacidade**

* **Descrição:** Devem ser implementadas medidas de segurança robustas: criptografia de dados em trânsito (TLS 1.3) e em repouso (AES-256), autenticação via JWT, proteção contra injeção SQL e XSS, em conformidade com a LGPD e ISO/IEC 27001.
* **Impacto:** RN-006, RN-008, HU09.

## **RNF-005 – Hardware: Robustez dos Sensores Físicos**

* **Descrição:** Os sensores IoT instalados em campo devem ser robustos e adequados para operar em condições ambientais extremas, suportando submersão contínua (IP68), variações bruscas de temperatura (-10°C a +60°C) e exposição prolongada a agentes químicos presentes no esgoto e água não tratada.
* **Critério sugerido:** manutenção da precisão das medições com variação ≤ 2% do valor real.
* **Impacto:** RF-01, RF-03.

## **RNF-006 – Controle de Permissões (RBAC)**

* **Descrição:** O sistema deve implementar controle de acesso baseado em perfis de usuário (Morador, ONG, Governante), restringindo funcionalidades de escrita conforme o papel atribuído.
* **Impacto:** RN-003, RF-19, HU06.

## **RNF-007 – Segurança de Dados**

* **Descrição:** Os dados armazenados no banco de dados devem possuir mecanismos de proteção, incluindo criptografia, controle de acesso e validação de integridade para evitar acesso indevido ou manipulação não autorizada dos dados hídricos.
* **Impacto:** RN-006, RN-008.

## **RNF-008 – Backup e Recuperação de Dados**

* **Descrição:** O sistema deve possuir mecanismos de backup periódico dos dados de qualidade da água, alertas e ocorrências, garantindo a possibilidade de recuperação em casos de falha, perda ou corrupção de dados.
* **Impacto:** RF-07, RF-24.

## **RNF-009 – Usabilidade e Acessibilidade**

* **Descrição:** A interface do sistema deve ser acessível, com suporte a alto contraste, fontes ajustáveis e navegação simplificada, permitindo que usuários com diferentes graus de literacia digital utilizem o sistema com mínima dificuldade.
* **Impacto:** HU03, HU08.

## **RNF-010 – Escalabilidade**

* **Descrição:** O sistema deve ser capaz de suportar aumento no número de usuários, regiões monitoradas e volume de dados de sensores IoT sem degradação significativa de desempenho.
* **Impacto:** RF-01, RF-25.

## **RNF-011 – Manutenibilidade**

* **Descrição:** O sistema deve possuir arquitetura modular e documentação adequada, permitindo a implementação de melhorias, correções e atualizações com impacto mínimo no funcionamento da aplicação.
* **Impacto:** Evolução futura do sistema.

## **RNF-012 – Dependência de Conectividade**

* **Descrição:** O sistema requer conexão com a internet para autenticação, sincronização de dados dos sensores IoT, envio de notificações push e integração com a API de mapas.
* **Impacto:** Todos os RF.

## **RNF-013 – Tempo de Resposta em Notificações**

* **Descrição:** O sistema deve processar e disparar notificações push de alerta de risco dentro de no máximo 30 segundos após a detecção de parâmetros críticos pelos sensores IoT.
* **Impacto:** RN-004, RF-04.

## **Notas de Versão**

* v1.0 (16/03/2026): Criação e definição dos Requisitos Não Funcionais com base no escopo do sistema Purify.
* v1.1 (02/04/2026): Ajuste do RNF-004 conforme conformidade com LGPD e ISO/IEC 27001.
