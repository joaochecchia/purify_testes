*** Settings ***
Library           SeleniumLibrary
Suite Setup       Dado que o usuário está autenticado como Morador
Suite Teardown    E fecha o navegador

*** Variables ***
${URL_REPORTAR}     http://localhost:5173/reportar
${BROWSER}          chrome
${SELECT_TIPO}      id=selectTipoProblema
${INPUT_DESC}       id=inputDescricao
${BTN_USAR_GPS}     id=btnUsarGPS
${BTN_ENVIAR}       id=btnEnviarReporte
${MSG_SUCESSO}      id=msgSucesso
${MSG_GPS}          id=msgErroGPS
${MSG_DESC}         id=msgErroDescricao
${GPS_CAPTURADO}    id=gpsCapturado

*** Test Cases ***
CT01 - Deve registrar reporte com GPS e descrição válidos
    [Documentation]    Valida fluxo completo de reporte de saneamento com localização GPS e descrição preenchidos (RF-24, RN-007)
    [Tags]             reporte    sucesso    gps    rf-24    rn-007
    Go To    ${URL_REPORTAR}
    Wait Until Element Is Visible    ${SELECT_TIPO}    timeout=5s
    Select From List By Value    ${SELECT_TIPO}    VAZAMENTO
    Input Text    ${INPUT_DESC}    Vazamento de água na calçada da Rua 12, próximo ao número 50.
    Click Button    ${BTN_USAR_GPS}
    Wait Until Element Is Visible    ${GPS_CAPTURADO}    timeout=5s
    Click Button    ${BTN_ENVIAR}
    Wait Until Element Is Visible    ${MSG_SUCESSO}    timeout=5s
    Element Text Should Contain    ${MSG_SUCESSO}    Reporte enviado com sucesso

CT02 - Deve bloquear envio sem localização GPS
    [Documentation]    Valida que o sistema bloqueia o envio do reporte quando a localização GPS não é fornecida (RN-007, RF-21)
    [Tags]             reporte    erro    gps    rn-007    rf-21
    Go To    ${URL_REPORTAR}
    Wait Until Element Is Visible    ${SELECT_TIPO}    timeout=5s
    Select From List By Value    ${SELECT_TIPO}    ESGOTO_ABERTO
    Input Text    ${INPUT_DESC}    Esgoto aberto na via pública.
    Click Button    ${BTN_ENVIAR}
    Wait Until Element Is Visible    ${MSG_GPS}    timeout=5s
    Element Text Should Contain    ${MSG_GPS}    Localização obrigatória

CT03 - Deve bloquear envio sem descrição
    [Documentation]    Valida que o sistema bloqueia o envio do reporte quando o campo de descrição está vazio (RF-23)
    [Tags]             reporte    erro    descricao    rf-23
    Go To    ${URL_REPORTAR}
    Wait Until Element Is Visible    ${SELECT_TIPO}    timeout=5s
    Select From List By Value    ${SELECT_TIPO}    FALTA_COLETA
    Click Button    ${BTN_USAR_GPS}
    Wait Until Element Is Visible    ${GPS_CAPTURADO}    timeout=5s
    Click Button    ${BTN_ENVIAR}
    Wait Until Element Is Visible    ${MSG_DESC}    timeout=5s
    Element Text Should Contain    ${MSG_DESC}    descreva o problema

*** Keywords ***
Dado que o usuário está autenticado como Morador
    Open Browser    http://localhost:5173/login    ${BROWSER}
    Maximize Browser Window
    Input Text        id=email    claudia@purify.com
    Input Password    id=senha    Morador@2026
    Click Button      id=btnLogin
    Wait Until Element Is Visible    id=navLogout    timeout=5s
    Set Selenium Speed    0.5 seconds

E fecha o navegador
    Close Browser
