>## 1. Introdução
>Esta página define o template e as instruções padrão que a nossa equipe do projeto **Purify** seguirá para a criação de casos de teste formais. O objetivo é garantir a padronização e a rastreabilidade na aplicação das técnicas de teste de Caixa Preta.

## 2. Instruções de Preenchimento
Cada página filha de caso de teste deve conter obrigatoriamente a seguinte estrutura:

* **ID e Título:** Identificador único do teste (ex: TC-EP1) e um título claro.
* **Responsável:** Nome do integrante do grupo.
* **Técnica Aplicada:** Partição de Equivalência (EP), Análise de Valor de Borda (BVA2) ou Tabela de Decisão (DT).
* **Rastreabilidade:** Referência ao Requisito (R#) ou Modo de Falha (F#).
* **Pré-condições:** Estado inicial necessário do sistema.
* **Modelagem:** A aplicação técnica (Inequações para EP, Conjuntos para BVA2, Matriz Lógica para DT).
* **Casos de Execução:** Tabela contendo Entrada, Saída Esperada e Status.

---

## 3. Template

**ID:** [Inserir ID] | **Título:** [Inserir Título]
**Responsável:** [Nome do Integrante]
**Técnica Aplicada:** [EP / BVA2 / DT]
**Rastreabilidade:** [Ref. Requisito / Modo de Falha]

### Pré-condições
1. [Condição 1]
2. [Condição 2]

### Modelagem da Técnica
[Inserir as partições, bordas ou tabela de decisão correspondente]

### Execução do Teste
| CT (Caso de Teste) | Dados de Entrada | Resultado Esperado |
| :--- | :--- | :--- |
| CT1 | [Entrada 1] | [Resultado 1] |
| CT2 | [Entrada 2] | [Resultado 2] |
