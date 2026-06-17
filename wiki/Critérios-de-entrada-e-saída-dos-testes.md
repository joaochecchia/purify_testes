# Critérios de Entrada e Saída dos Testes

Esta página define formalmente as condições que devem ser satisfeitas para **iniciar** e para **encerrar** cada fase de testes do projeto **Purify**, garantindo que os testes sejam conduzidos no momento e nas condições adequadas.
**Responsável:** João Gabriel Brito

## 1. Introdução

Critérios de entrada e saída (também chamados de *Entry Criteria* e *Exit Criteria*) são parte fundamental do processo de qualidade. Eles evitam que testes sejam executados em ambientes não preparados (desperdício de esforço) e que releases sejam aprovados sem atingir o nível mínimo de qualidade exigido.

## 2. Critérios de Entrada (Entry Criteria)

As condições abaixo devem ser **todas satisfeitas** antes do início de qualquer ciclo formal de testes:

### 2.1 Ambiente e Infraestrutura

- [ ] Ambiente de testes configurado e estável (servidor de API, banco de dados, simulador de sensores IoT)
- [ ] Build da versão a ser testada implantado com sucesso no ambiente de testes
- [ ] Dados de teste preparados (usuários com diferentes perfis, regiões cadastradas, dados históricos)
- [ ] Ferramentas de teste instaladas e funcionando (Postman, Robot Framework, JMeter, etc.)

### 2.2 Documentação

- [ ] Casos de teste revisados e aprovados pela equipe
- [ ] Rastreabilidade dos casos de teste com os requisitos confirmada
- [ ] Plano de Qualidade atualizado para o ciclo corrente
- [ ] Riscos identificados no FMEA revisados e ações de controle definidas

### 2.3 Desenvolvimento

- [ ] Funcionalidades do escopo do ciclo implementadas e integradas
- [ ] Testes unitários executados pelo desenvolvedor (cobertura mínima local atingida)
- [ ] Pull Requests do ciclo aprovados e mergeados na branch de testes
- [ ] Nenhum defeito crítico em aberto de ciclos anteriores sem tratativa

## 3. Critérios de Saída (Exit Criteria)

O ciclo de testes é considerado **encerrado e aprovado** quando todas as condições abaixo forem atingidas:

### 3.1 Cobertura e Execução

- [ ] 100% dos casos de teste planejados foram executados (ou documentados como bloqueados com justificativa)
- [ ] Taxa de aprovação geral ≥ **95%** dos casos de teste executados
- [ ] Cobertura de código ≥ **80%** (validado pelo SonarQube ou ferramenta equivalente)
- [ ] Cobertura de 100% nos módulos críticos: geração de alertas (RN-004), autenticação e controle de acesso (RBAC)

### 3.2 Defeitos

- [ ] Nenhum defeito com severidade **Crítico** em aberto (especialmente nos módulos de alerta e dados hídricos)
- [ ] Nenhum defeito com severidade **Alto** em aberto sem previsão de correção documentada
- [ ] Todos os defeitos registrados possuem: descrição, severidade, responsável e status

### 3.3 Qualidade do Plano de Qualidade (ISO/IEC 25010)

- [ ] Meta de adequação funcional atingida (≥ 85% de satisfação dos usuários)
- [ ] Taxa de falhas < 5% nas funcionalidades principais
- [ ] Disponibilidade ≥ 99,5% durante o período de testes
- [ ] Tempo de resposta das operações principais ≤ 2 segundos (RNF-001)
- [ ] 0 acessos indevidos identificados nos testes de controle de acesso (RBAC)
- [ ] Alertas gerados corretamente para todos os parâmetros fora dos limites (RN-004)

### 3.4 Documentação de Saída

- [ ] Relatório de Execução de Testes preenchido e atualizado
- [ ] Defeitos registrados nas Issues do repositório
- [ ] Rastreabilidade atualizada (matriz de rastreabilidade)
- [ ] Aprovação formal do encerramento pelo responsável de qualidade da equipe

## 4. Critérios por Fase de Teste

### 4.1 Testes Unitários (Caixa Branca)

| Critério de Entrada | Critério de Saída |
| :--- | :--- |
| Módulo implementado e compilando | Cobertura ≥ 80% do módulo |
| Dependências mockadas disponíveis | Todos os testes unitários passando (0 falhas) |
| Ambiente de desenvolvimento configurado | Relatório de cobertura gerado |

### 4.2 Testes de API (Caixa Preta)

| Critério de Entrada | Critério de Saída |
| :--- | :--- |
| API implantada no ambiente de testes | 100% dos endpoints testados |
| Coleção Postman preparada | Taxa de sucesso ≥ 95% |
| Dados de teste disponíveis (usuários, regiões, dados hídricos) | Relatório de execução do Newman gerado |

### 4.3 Testes de Interface (Robot Framework)

| Critério de Entrada | Critério de Saída |
| :--- | :--- |
| Aplicativo acessível no ambiente de testes | 100% dos fluxos testados |
| Browser/dispositivo configurado | 0 falhas nos fluxos críticos |
| Suíte Robot Framework configurada | Relatório log.html gerado |

### 4.4 Testes de Carga e Desempenho

| Critério de Entrada | Critério de Saída |
| :--- | :--- |
| Ambiente de carga configurado (JMeter) | P95 de latência ≤ 2 segundos |
| Dados de teste em volume representativo | 0 erros durante a execução de carga normal |

## 5. Exceções e Saídas Antecipadas

Em casos excepcionais, o encerramento do ciclo pode ser autorizado mesmo com critérios não totalmente atingidos, **desde que**:

- Todos os defeitos críticos estejam tratados ou com plano de mitigação documentado;
- Os módulos de geração de alertas (RN-004) e autenticação (RF-11) estejam 100% aprovados;
- A equipe e o orientador tenham sido formalmente notificados e concordado com a saída antecipada.
