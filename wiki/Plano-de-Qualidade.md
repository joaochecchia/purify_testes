# Plano de Qualidade

## Introdução

Este Plano de Qualidade define os critérios utilizados para avaliar a qualidade do sistema **Purify**, utilizando como base o modelo de qualidade definido pela norma **ISO/IEC 25010**. O objetivo é estabelecer metas mensuráveis para os atributos de qualidade relevantes do sistema de monitoramento da qualidade da água, bem como definir métricas e métodos de validação que permitam verificar se essas metas foram atingidas.

---

# 1. Adequação Funcional

A Adequação Funcional mede o quanto as funcionalidades do sistema atendem às necessidades dos usuários no contexto de monitoramento hídrico.

## a. Adequação

### Meta de qualidade

Pelo menos **85% dos usuários devem considerar que o sistema atende às suas necessidades principais** de monitoramento e alertas de qualidade da água.

### Como confirmar que a meta foi atingida

Aplicação de questionários ou entrevistas com usuários (moradores, técnicos de ONG e gestores governamentais) após a utilização do sistema.

### Métrica utilizada

Taxa de adequação = (Número de usuários satisfeitos / Número total de usuários avaliados) × 100

---

## b. Completude

### Meta de qualidade

O sistema deve implementar **100% dos 25 requisitos funcionais** definidos no Documento de Requisitos (RF-01 a RF-25).

### Como confirmar que a meta foi atingida

Comparação entre os requisitos especificados e as funcionalidades implementadas, por meio de uma matriz de rastreabilidade.

### Métrica utilizada

Completude funcional = (Número de funcionalidades implementadas / Número total de funcionalidades especificadas)

---

## c. Correção

### Meta de qualidade

Pelo menos **95% das execuções das funcionalidades devem ocorrer sem erros**, especialmente nos fluxos críticos de alerta e registro de dados.

### Como confirmar que a meta foi atingida

Execução de testes funcionais e registro das falhas encontradas durante os ciclos de teste.

### Métrica utilizada

Taxa de correção = (Número de execuções sem falha / Número total de execuções)

---

# 2. Confiabilidade

A Confiabilidade mede a capacidade do sistema de operar corretamente e de forma contínua, característica essencial para um sistema de monitoramento ambiental em tempo real.

## a. Ocorrência de Falhas

### Meta de qualidade

Taxa de falhas inferior a **5% durante os testes do sistema**, especialmente nos módulos de geração de alertas e recebimento de dados de sensores.

### Como confirmar que a meta foi atingida

Execução repetida de testes nas funcionalidades principais do sistema, com registro de falhas.

### Métrica utilizada

Taxa de falhas = Número de falhas / Número de execuções

---

## b. Disponibilidade

### Meta de qualidade

O sistema deve apresentar **disponibilidade mínima de 99,5% durante o período de testes**, conforme definido no RNF-003.

### Como confirmar que a meta foi atingida

Monitoramento do tempo em que o sistema permanece operacional através de ferramentas de uptime monitoring.

### Métrica utilizada

Disponibilidade = (Tempo em funcionamento / Tempo total observado) × 100

### Ferramentas ou procedimentos de medição

- **Uptime Robot** ou **Datadog** para monitoramento contínuo em ambiente de produção.
- Registro de todos os incidentes de indisponibilidade com causa raiz documentada.

---

## c. Tolerância a Falhas

### Meta de qualidade

Pelo menos **90% das falhas devem ser tratadas adequadamente pelo sistema**, sem causar interrupção total da aplicação. Erros de sensores IoT não devem derrubar o sistema; devem ser registrados como "dado ausente".

### Como confirmar que a meta foi atingida

Testes simulando falhas de sensores, erros de entrada de dados ou perda de conectividade.

### Métrica utilizada

Tolerância a falhas = (Número de falhas tratadas / Número total de falhas simuladas)

---

## d. Recuperabilidade

### Meta de qualidade

O sistema deve ser capaz de **restaurar seu funcionamento em até 5 minutos após uma falha** não planejada, sem perda de dados já persistidos.

### Como confirmar que a meta foi atingida

Simulação de falhas no backend e medição do tempo necessário para restabelecer o sistema.

### Métrica utilizada

Tempo médio de recuperação após falha (MTTR).

---

# 3. Segurança da Informação

A Segurança da Informação no sistema Purify tem como objetivo proteger os dados sensíveis dos usuários (CPF/CNPJ, localização GPS, histórico de reportes) e garantir a integridade dos dados hídricos publicados. Considerando as exigências da Lei Geral de Proteção de Dados (LGPD), o projeto prevê a contratação de uma empresa especializada em segurança da informação para apoiar na implementação de práticas de proteção e validação da segurança do sistema.

Para este projeto, nossa equipe optou pela empresa **SecureWater Consulting**, especializada em segurança da informação para sistemas IoT e aplicações governamentais, gestão de riscos e testes de vulnerabilidade. A empresa auxiliará na análise de riscos, identificação de vulnerabilidades, testes de segurança e definição de boas práticas para proteção dos dados armazenados no sistema.

## a. Confidencialidade

### Meta de qualidade

Apenas usuários autenticados devem acessar as informações restritas do sistema. A empresa SecureWater Consulting auxiliará na análise de controles de acesso e na identificação de vulnerabilidades que possam permitir acesso indevido.

### Como confirmar que a meta foi atingida

Testes de controle de acesso com diferentes perfis de usuário (Morador, ONG, Governante), verificando se usuários não autorizados conseguem acessar dados ou funcionalidades restritas.

### Métrica utilizada

Número de acessos indevidos identificados.

Meta: **0 acessos indevidos**

### Ferramentas ou procedimentos de medição

- Testes manuais de controle de acesso
- Simulação de diferentes perfis de usuário (RBAC)
- Auditoria de permissões no sistema e nos endpoints da API

---

## b. Autenticidade

### Meta de qualidade

Garantir que **100% dos usuários sejam autenticados antes de acessar funcionalidades protegidas do sistema**, assegurando que apenas usuários legítimos utilizem a plataforma. A empresa **SecureWater Consulting** auxiliará na verificação da implementação de mecanismos seguros de autenticação JWT.

### Como confirmar que a meta foi atingida

Testes de autenticação verificando se todas as funcionalidades protegidas exigem token JWT válido antes do acesso.

### Métrica utilizada

Taxa de autenticação válida = (Número de acessos autenticados / Número total de acessos)

Meta: **100% dos acessos autenticados**

### Ferramentas ou procedimentos de medição

- Testes de autenticação via Postman nas rotas protegidas da API
- Verificação das rotas que exigem token JWT
- Análise do fluxo de login e expiração de sessão

---

## c. Responsabilidade

### Meta de qualidade

Garantir que **todas as ações relevantes do sistema sejam registradas em logs**, permitindo rastrear atividades realizadas pelos usuários, especialmente inserção de dados técnicos e reportes de saneamento.

### Como confirmar que a meta foi atingida

Verificação da existência de registros de auditoria contendo ações como:

- Registro de dados de qualidade da água
- Reporte de problemas de saneamento
- Exclusão de conta

### Métrica utilizada

Percentual de ações relevantes registradas em log.

Meta: **100% das ações críticas registradas**

### Ferramentas ou procedimentos de medição

- Análise manual dos registros de log do backend
- Verificação dos eventos gerados pelo sistema no banco de dados

---

## d. Integridade

### Meta de qualidade

Garantir que **os dados hídricos armazenados não sofram alterações indevidas**, mantendo a confiabilidade das informações publicadas para a população. A empresa **SecureWater Consulting** auxiliará na identificação de vulnerabilidades de manipulação de dados.

### Como confirmar que a meta foi atingida

Testes de manipulação de dados e verificação de validações no sistema.

### Métrica utilizada

Número de inconsistências ou alterações indevidas detectadas.

Meta: **0 inconsistências**

### Ferramentas ou procedimentos de medição

- Testes de validação de entrada de dados (pH, turbidez, coliformes)
- Verificação de restrições no banco de dados (CHECK constraints, foreign keys)
- Simulação de tentativas de alteração indevida via requisições maliciosas

---

## e. Não Repúdio

### Meta de qualidade

Garantir que **todas as ações importantes realizadas no sistema possuam registro identificando o usuário responsável**, impedindo que um usuário técnico negue ter inserido dados críticos que geraram alertas.

### Como confirmar que a meta foi atingida

Verificação de registros contendo identificação do usuário, data, hora e tipo de operação.

### Métrica utilizada

Percentual de ações críticas registradas com identificação do usuário.

Meta: **100% das ações críticas registradas com identificação**

---

## f. Resistência

### Meta de qualidade

Garantir que o sistema seja capaz de **resistir a tentativas básicas de acesso indevido**, como ataques de força bruta no login e injeção de parâmetros hídricos inválidos. A empresa **SecureWater Consulting** auxiliará na realização de testes de penetração.

### Como confirmar que a meta foi atingida

Testes simulando tentativas de login com credenciais inválidas, envio de valores fora do domínio (pH negativo, turbidez acima de 1000 NTU) e acesso a funcionalidades sem permissão.

### Métrica utilizada

Número de tentativas de acesso inválido bloqueadas.

Meta: **100% das tentativas inválidas devem ser bloqueadas**

### Ferramentas ou procedimentos de medição

- Testes de segurança manuais e automatizados
- Penetration Testing trimestral pela SecureWater Consulting
- Análise estática de código (SAST) com ferramentas como SonarQube

---

# 4. Desempenho e Eficiência

A característica de Desempenho e Eficiência avalia o comportamento do sistema em relação à quantidade de recursos utilizados, sendo crítica para um sistema de monitoramento em tempo real com sensores IoT.

## a. Comportamento em relação ao Tempo

### Meta de qualidade

O sistema deve apresentar tempos de resposta ágeis para garantir uma excelente experiência ao usuário. A meta é que as operações principais (consulta de qualidade da água, exibição de dashboard, registro de dados) ocorram em até **2 segundos** para 95% das requisições (RNF-001).

### Como confirmar que a meta foi atingida

Realização de testes dinâmicos de performance monitorando o tempo de resposta da API e o tempo de renderização da interface durante cenários de uso normal e de pico.

### Métrica utilizada

Tempo médio de resposta por transação (em segundos) e percentil 95 de latência.

### Ferramentas ou procedimentos de medição

- **Apache JMeter** ou **K6** simulando múltiplos usuários simultâneos.
- Monitoramento contínuo em ambiente de produção com **New Relic** ou **Datadog**.

---

## b. Utilização de Recursos

### Meta de qualidade

O sistema e seus serviços devem ser otimizados, consumindo no máximo **20% de CPU** em ociosidade e trafegando payloads de no máximo **1MB** por requisição padrão.

### Como confirmar que a meta foi atingida

Monitoramento ativo do consumo de infraestrutura durante a execução dos cenários de teste de carga.

### Métrica utilizada

Percentual de uso de CPU (%), consumo de memória RAM (MB) e tamanho do payload de rede (MB).

### Ferramentas ou procedimentos de medição

- Dashboards de monitoramento em nuvem (**AWS CloudWatch** ou **Azure Monitor**).
- Ferramentas de profiling de código no backend.

---

## c. Capacidade

### Meta de qualidade

A arquitetura deve suportar o volume máximo de usuários simultâneos previstos sem apresentar degradação no serviço, considerando picos de acesso durante eventos de contaminação amplamente divulgados.

### Como confirmar que a meta foi atingida

Execução de testes de estresse para encontrar o ponto de saturação da aplicação.

### Métrica utilizada

Capacidade máxima de usuários suportados = (Recurso Total Disponível / Recurso Consumido por Usuário).

### Ferramentas ou procedimentos de medição

- Testes de estresse com **JMeter** ou **Gatling**, gerando tráfego massivo simulado.

---

# 5. Compatibilidade

Avalia a capacidade do sistema de operar corretamente em diferentes dispositivos e de se integrar com sensores IoT e APIs externas.

## a. Coexistência

### Meta de qualidade

O aplicativo Purify deve operar perfeitamente no dispositivo do usuário (smartphone Android/iOS) sem conflitar com outros aplicativos ou drenar excessivamente os recursos do sistema operacional.

### Como confirmar que a meta foi atingida

Execução do sistema em dispositivos com outros processos concorrentes e análise de logs do SO em busca de memory leaks.

### Métrica utilizada

Número de interrupções, falhas ou crashes gerados por conflito de recursos.

Meta: **0 falhas por conflito de recursos**

### Ferramentas ou procedimentos de medição

- Testes dinâmicos em Device Farms (**AWS Device Farm** ou **BrowserStack**).

---

## b. Interoperabilidade

### Meta de qualidade

O sistema deve se comunicar perfeitamente com todos os sensores IoT e APIs externas definidos no projeto (API de Mapas, sensores de pH/turbidez/coliformes).

### Como confirmar que a meta foi atingida

Execução de testes de integração validando os contratos de dados (JSON) e os códigos de status HTTP retornados.

### Métrica utilizada

Taxa de sucesso nas requisições de integração = (Nº de requisições bem-sucedidas / Nº total de requisições) × 100.

Meta: **100%**

### Ferramentas ou procedimentos de medição

- Automação de testes de contrato com **Postman** e **Newman**.

---

# 6. Manutenibilidade

Avalia o grau de eficácia com que o sistema pode ser modificado, corrigido ou melhorado pela equipe.

## a. Modularização e Reusabilidade

### Meta de qualidade

O código deve possuir arquitetura em módulos independentes, garantindo que componentes como o módulo de alertas, o módulo de mapas e o módulo de histórico possam ser reaproveitados e modificados de forma isolada.

### Como confirmar que a meta foi atingida

Revisões arquiteturais e análise estática automatizada para identificar trechos duplicados ou com alto acoplamento.

### Métrica utilizada

Índice de duplicação de código.

Meta: **Inferior a 5%**

### Ferramentas ou procedimentos de medição

- **SonarQube** integrado à esteira de Pull Requests.

---

## b. Legibilidade e Modificabilidade

### Meta de qualidade

O código fonte deve ser de fácil compreensão, seguindo padrões estabelecidos, permitindo que a equipe identifique rapidamente falhas nos módulos de alerta e implemente novas funcionalidades.

### Como confirmar que a meta foi atingida

Aplicação de linters, auditoria de padrões sintáticos e aprovação obrigatória de Pull Requests.

### Métrica utilizada

Quantidade de problemas de padronização e Débito Técnico (em horas).

Meta: **Tendência de redução contínua**

### Ferramentas ou procedimentos de medição

- **ESLint/Prettier** para formatação no repositório.
- **SonarQube** para cálculo de Débito Técnico.

---

## c. Testabilidade

### Meta de qualidade

Os componentes do sistema devem ser construídos de forma isolada, especialmente o módulo de geração de alertas (RN-004), facilitando a injeção de dependências e a criação de testes unitários para as regras de negócio.

### Como confirmar que a meta foi atingida

Criação e execução contínua de testes unitários e de integração automatizados.

### Métrica utilizada

Cobertura de código.

Meta: **Pelo menos 80% do código útil coberto por testes**

### Ferramentas ou procedimentos de medição

- Frameworks de teste automatizado com relatórios de cobertura gerados no pipeline de CI/CD.

---

# 7. Segurança dos Dados Ambientais e da Saúde Pública

Devido à natureza crítica do sistema — dados de qualidade da água que impactam diretamente a saúde pública — esta característica avalia a mitigação de riscos que possam afetar a integridade das informações hídricas.

## a. Prevenção de Riscos à Saúde Pública

### Meta de qualidade

Informações críticas sobre qualidade da água (pH, turbidez, coliformes) **não podem apresentar erros, atrasos na notificação ou inconsistência de exibição**. Um alerta falso ou a ausência de um alerta real podem colocar a saúde da população em risco.

### Como confirmar que a meta foi atingida

Aplicação de técnicas formais de modelagem de testes, especificamente **Análise de Valor Limite (BVA)** e **Tabela de Decisão (DT)**, validando todos os parâmetros de pH, turbidez e coliformes contra os limites da Portaria GM/MS nº 888/2021.

### Métrica utilizada

Número de defeitos críticos encontrados nos fluxos de alerta e exibição de parâmetros hídricos.

Meta: **0 defeitos aceitáveis em produção**

### Ferramentas ou procedimentos de medição

- Testes End-to-End com **Cypress** ou **Selenium**, focados nos fluxos de alerta e registro de dados.
- Auditoria de banco de dados para garantir integridade referencial.

---

# 8. Flexibilidade, Portabilidade e Escalabilidade

Avalia a capacidade do sistema de se manter robusto frente a mudanças no ambiente e ao crescimento do número de regiões monitoradas.

## a. Adaptabilidade e Portabilidade

### Meta de qualidade

O sistema deve se adaptar automaticamente a diferentes resoluções de tela (smartphones Android e iOS) e funcionar perfeitamente em todas as plataformas suportadas.

### Como confirmar que a meta foi atingida

Testes de interface do usuário (UI) e testes de compatibilidade nas principais plataformas.

### Métrica utilizada

Taxa de conformidade multiplataforma: % de fluxos concluídos com sucesso sem quebras de layout.

Meta: **100%**

### Ferramentas ou procedimentos de medição

- Testes responsivos com **Chrome DevTools**.
- Execução de suítes em múltiplos dispositivos reais com **BrowserStack**.

---

## b. Instalabilidade e Substituabilidade

### Meta de qualidade

O processo de implantação deve ser totalmente automatizado, garantindo que o sistema possa ser atualizado sem longo tempo de indisponibilidade para os usuários.

### Como confirmar que a meta foi atingida

Realização de deployments simulados em ambientes de staging.

### Métrica utilizada

Tempo de setup/implantação automatizada.

Meta: **Inferior a 15 minutos do código à produção**

### Ferramentas ou procedimentos de medição

- Conteinerização com **Docker**.
- Pipelines de CI/CD com **GitHub Actions**.

---

## c. Escalabilidade

### Meta de qualidade

A arquitetura do sistema deve permitir o crescimento horizontal, adicionando novas regiões de monitoramento e novos sensores IoT sem exigir reescrita de código ou interrupção do serviço.

### Como confirmar que a meta foi atingida

Simulação de pico de acessos e ativação de gatilhos de autoescalonamento em nuvem.

### Métrica utilizada

Tempo de resposta durante criação de novas instâncias frente à carga extra.

### Ferramentas ou procedimentos de medição

- Configuração de **Auto Scaling Groups** em provedores de nuvem (AWS ou Azure).
- Orquestração com **Kubernetes (K8s)** e **Load Balancers**.
