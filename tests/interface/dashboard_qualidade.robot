*** Settings ***
Library           SeleniumLibrary
Suite Setup       Dado que o usuário está autenticado no dashboard
Suite Teardown    E fecha o navegador

*** Variables ***
${URL_LOGIN}        http://localhost:5173/login
${URL_DASHBOARD}    http://localhost:5173/dashboard
${BROWSER}          chrome
${INPUT_REGIAO}     id=campoPesquisaRegiao
${BTN_PESQUISAR}    id=btnPesquisar
${INDICADOR_PH}     id=indicadorPH
${INDICADOR_COR}    id=statusQualidade
${MSG_SEM_DADOS}    id=msgSemDados

*** Test Cases ***
CT01 - Deve exibir dashboard verde para região com dados seguros
    Dado que o usuario seleciona a regiao    Asa Norte
    Quando o dashboard for carregado
    Entao o indicador de qualidade deve ser    SEGURO
    E o indicador de pH deve estar visível

CT02 - Deve exibir alerta vermelho para região com parâmetros críticos
    Dado que o usuario seleciona a regiao    Região Crítica Teste
    Quando o dashboard for carregado
    Entao o indicador de qualidade deve ser    CRÍTICO
    E um pop-up de alerta deve ser exibido

CT03 - Deve exibir mensagem quando região não possui dados
    Dado que o usuario seleciona a regiao    Zona Rural Sem Dados
    Quando o dashboard for carregado
    Entao a mensagem de ausência de dados deve ser exibida

*** Keywords ***
Dado que o usuário está autenticado no dashboard
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window
    Input Text        id=email    joao@purify.com
    Input Password    id=senha    Purify@2026
    Click Button      id=btnLogin
    Wait Until Element Is Visible    id=navLogout    timeout=5s
    Set Selenium Speed    0.5 seconds

Dado que o usuario seleciona a regiao
    [Arguments]    ${regiao}
    Go To    ${URL_DASHBOARD}
    Wait Until Element Is Visible    ${INPUT_REGIAO}    timeout=5s
    Input Text    ${INPUT_REGIAO}    ${regiao}
    Click Button    ${BTN_PESQUISAR}

Quando o dashboard for carregado
    Wait Until Element Is Visible    ${INDICADOR_COR}    timeout=5s

Entao o indicador de qualidade deve ser
    [Arguments]    ${status}
    Element Text Should Be    ${INDICADOR_COR}    ${status}

E o indicador de pH deve estar visível
    Element Should Be Visible    ${INDICADOR_PH}

E um pop-up de alerta deve ser exibido
    Wait Until Element Is Visible    id=popupAlerta    timeout=3s

Entao a mensagem de ausência de dados deve ser exibida
    Wait Until Element Is Visible    ${MSG_SEM_DADOS}    timeout=5s
    Element Text Should Contain    ${MSG_SEM_DADOS}    Não existem dados registrados

E fecha o navegador
    Close Browser
