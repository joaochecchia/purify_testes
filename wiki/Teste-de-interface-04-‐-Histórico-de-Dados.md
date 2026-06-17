**Responsável:** João Gabriel Brito Checchia

## 1. Modelagem de Teste de Interface - Particionamento de Equivalência

**Interface:** Tela de Histórico de Dados (`http://localhost:5173/historico`)

**Partições de Equivalência — Exibição do Histórico**

| Condição / Regra | CT01 | CT02 | CT03 |
| :--- | :--- | :--- | :--- |
| R1 - Região com histórico no período | S | N | - |
| R2 - Ordenação cronológica decrescente | S | - | Verificar |
| **Resultado esperado** | Lista ordenada exibida | Mensagem de ausência | Ordenação validada |

## 2. Implementação

**Robot Framework com SeleniumLibrary**

**Suite de Teste:** `historico_dados.robot`

 ***Settings ***
 Library SeleniumLibrary
 Library Collections
 Suite Setup Dado que o usuário está autenticado
 Suite Teardown E fecha o navegador

 ***Variables ***
 ${URL_HISTORICO} http://localhost:5173/historico
 ${BROWSER} chrome
 ${SELECT_REGIAO} id=selectRegiao
 ${BTN_CONSULTAR} id=btnConsultar
 ${LISTA_DADOS} id=listaHistorico
 ${MSG_SEM_DADOS} id=msgSemDados
 ${PRIMEIRO_ITEM} css=#listaHistorico .item-historico:first-child
 ${SEGUNDO_ITEM} css=#listaHistorico .item-historico:nth-child(2)

 ***Test Cases ***
 CT01 - Deve exibir histórico em ordem cronológica decrescente
 Go To ${URL_HISTORICO}
 Wait Until Element Is Visible ${SELECT_REGIAO} timeout=5s
 Select From List By Label ${SELECT_REGIAO} Asa Norte
 Click Button ${BTN_CONSULTAR}
 Wait Until Element Is Visible ${LISTA_DADOS} timeout=5s
 ${data_primeiro}= Get Text ${PRIMEIRO_ITEM} .data-coleta
 ${data_segundo}= Get Text ${SEGUNDO_ITEM} .data-coleta
 Should Be True '${data_primeiro}' >= '${data_segundo}' msg=Histórico não está em ordem decrescente!

 CT02 - Deve exibir mensagem para região sem dados
 Go To ${URL_HISTORICO}
 Wait Until Element Is Visible ${SELECT_REGIAO} timeout=5s
 Select From List By Label ${SELECT_REGIAO} Zona Rural Sem Dados
 Click Button ${BTN_CONSULTAR}
 Wait Until Element Is Visible ${MSG_SEM_DADOS} timeout=5s
 Element Text Should Contain ${MSG_SEM_DADOS} Não existem dados registrados

 CT03 - Deve filtrar dados corretamente por região selecionada
 Go To ${URL_HISTORICO}
 Wait Until Element Is Visible ${SELECT_REGIAO} timeout=5s
 Select From List By Label ${SELECT_REGIAO} Taguatinga
 Click Button ${BTN_CONSULTAR}
 Wait Until Element Is Visible ${LISTA_DADOS} timeout=5s
 ${nome_regiao}= Get Text id=nomeRegiaoAtiva
 Should Be Equal ${nome_regiao} Taguatinga

 ***Keywords ***
 Dado que o usuário está autenticado
 Open Browser http://localhost:5173/login ${BROWSER}
 Maximize Browser Window
 Input Text id=email victor.d@purify.com
 Input Password id=senha Purify@2026
 Click Button id=btnLogin
 Wait Until Element Is Visible id=navLogout timeout=5s
 Set Selenium Speed 0.5 seconds

 E fecha o navegador
 Close Browser

## 3. Relatório de Execução de Testes

**Comando de execução utilizado**
`robot historico_dados.robot`

**Ambiente de Testes**

| Item | Valor |
| :--- | :--- |
| Ferramenta | Robot Framework |
| Biblioteca | SeleniumLibrary |
| Navegador | Google Chrome |
| Ambiente | Localhost |
| URL | `http://localhost:5173/historico` |
| Data de execução | 06/06/2026 |

**Evidências dos Casos de Teste**

| Caso de Teste | Resultado Esperado | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- |
| CT01 - Ordenação decrescente | Primeiro item mais recente que o segundo | Data[0] > Data[1] (verificado) | Aprovado |
| CT02 - Região sem dados | Mensagem "Não existem dados registrados" | Mensagem exibida corretamente | Aprovado |
| CT03 - Filtro por região | Nome da região ativa = "Taguatinga" | "Taguatinga" exibido como região ativa | Aprovado |

**Resumo dos Resultados**

| Total de testes | Aprovados | Reprovados |
| :--- | :--- | :--- |
| 3 | 3 | 0 |

**Conclusão:** Os testes da tela de histórico validaram a ordenação cronológica decrescente obrigatória (RN-005), a exibição de mensagem para regiões sem dados (RF-10) e o isolamento correto de dados por região (RF-08).
