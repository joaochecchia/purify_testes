*** Settings ***
Library           SeleniumLibrary
Library           Collections
Suite Setup       Dado que o usuário está autenticado
Suite Teardown    E fecha o navegador

*** Variables ***
${URL_HISTORICO}    http://localhost:5173/historico
${BROWSER}          chrome
${SELECT_REGIAO}    id=selectRegiao
${BTN_CONSULTAR}    id=btnConsultar
${LISTA_DADOS}      id=listaHistorico
${MSG_SEM_DADOS}    id=msgSemDados
${PRIMEIRO_ITEM}    css=#listaHistorico .item-historico:first-child
${SEGUNDO_ITEM}     css=#listaHistorico .item-historico:nth-child(2)

*** Test Cases ***
CT01 - Deve exibir histórico em ordem cronológica decrescente
    [Documentation]    Valida que o histórico de dados é exibido em ordenação cronológica decrescente (RN-005)
    [Tags]             historico    ordenacao    rn-005
    Go To    ${URL_HISTORICO}
    Wait Until Element Is Visible    ${SELECT_REGIAO}    timeout=5s
    Select From List By Label    ${SELECT_REGIAO}    Asa Norte
    Click Button    ${BTN_CONSULTAR}
    Wait Until Element Is Visible    ${LISTA_DADOS}    timeout=5s
    ${data_primeiro}=    Get Text    ${PRIMEIRO_ITEM} .data-coleta
    ${data_segundo}=    Get Text    ${SEGUNDO_ITEM} .data-coleta
    Should Be True    '${data_primeiro}' >= '${data_segundo}'    msg=Histórico não está em ordem decrescente!

CT02 - Deve exibir mensagem para região sem dados
    [Documentation]    Valida a mensagem de ausência de dados para região sem registros cadastrados (RF-10)
    [Tags]             historico    sem-dados    rf-10
    Go To    ${URL_HISTORICO}
    Wait Until Element Is Visible    ${SELECT_REGIAO}    timeout=5s
    Select From List By Label    ${SELECT_REGIAO}    Zona Rural Sem Dados
    Click Button    ${BTN_CONSULTAR}
    Wait Until Element Is Visible    ${MSG_SEM_DADOS}    timeout=5s
    Element Text Should Contain    ${MSG_SEM_DADOS}    Não existem dados registrados

CT03 - Deve filtrar dados corretamente por região selecionada
    [Documentation]    Valida que os dados exibidos correspondem exclusivamente à região selecionada (RF-08)
    [Tags]             historico    filtro    rf-08
    Go To    ${URL_HISTORICO}
    Wait Until Element Is Visible    ${SELECT_REGIAO}    timeout=5s
    Select From List By Label    ${SELECT_REGIAO}    Taguatinga
    Click Button    ${BTN_CONSULTAR}
    Wait Until Element Is Visible    ${LISTA_DADOS}    timeout=5s
    ${nome_regiao}=    Get Text    id=nomeRegiaoAtiva
    Should Be Equal    ${nome_regiao}    Taguatinga

*** Keywords ***
Dado que o usuário está autenticado
    Open Browser    http://localhost:5173/login    ${BROWSER}
    Maximize Browser Window
    Input Text        id=email    victor.d@purify.com
    Input Password    id=senha    Purify@2026
    Click Button      id=btnLogin
    Wait Until Element Is Visible    id=navLogout    timeout=5s
    Set Selenium Speed    0.5 seconds

E fecha o navegador
    Close Browser
