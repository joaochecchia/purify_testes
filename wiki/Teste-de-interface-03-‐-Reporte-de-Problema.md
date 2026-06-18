**Responsável:** João Gabriel Brito Checchia

## 1. Modelagem de Teste de Interface - Tabela de Decisão

**Interface:** Tela de Reporte de Problema de Saneamento (`http://localhost:5173/reportar`)

**Tabela de Decisão**

| Condição / Regra | CT01 | CT02 | CT03 |
| :--- | :--- | :--- | :--- |
| R1 - GPS disponível | S | N | S |
| R2 - Descrição preenchida | S | S | N |
| **Resultado esperado** | Reporte enviado | GPS obrigatório | Descrição obrigatória |

## 2. Implementação

**Robot Framework com SeleniumLibrary**

**Arquivo do script:** [`tests/interface/reporte_saneamento.robot`](https://github.com/joaochecchia/purify_testes/blob/main/tests/interface/reporte_saneamento.robot)

**Suite de Teste:** `reporte_saneamento.robot`

 ***Settings ***
 Library SeleniumLibrary
 Suite Setup Dado que o usuário está autenticado como Morador
 Suite Teardown E fecha o navegador

 ***Variables ***
 ${URL_REPORTAR} http://localhost:5173/reportar
 ${BROWSER} chrome
 ${SELECT_TIPO} id=selectTipoProblema
 ${INPUT_DESC} id=inputDescricao
 ${BTN_USAR_GPS} id=btnUsarGPS
 ${BTN_ENVIAR} id=btnEnviarReporte
 ${MSG_SUCESSO} id=msgSucesso
 ${MSG_GPS} id=msgErroGPS
 ${MSG_DESC} id=msgErroDescricao

 ***Test Cases ***
 CT01 - Deve registrar reporte com GPS e descrição válidos
 Go To ${URL_REPORTAR}
 Wait Until Element Is Visible ${SELECT_TIPO} timeout=5s
 Select From List By Value ${SELECT_TIPO} VAZAMENTO
 Input Text ${INPUT_DESC} Vazamento de água na calçada da Rua 12, próximo ao 50.
 Click Button ${BTN_USAR_GPS}
 Wait Until Element Is Visible id=gpsCapturado timeout=5s
 Click Button ${BTN_ENVIAR}
 Wait Until Element Is Visible ${MSG_SUCESSO} timeout=5s
 Element Text Should Contain ${MSG_SUCESSO} Reporte enviado com sucesso

 CT02 - Deve bloquear envio sem GPS
 Go To ${URL_REPORTAR}
 Wait Until Element Is Visible ${SELECT_TIPO} timeout=5s
 Select From List By Value ${SELECT_TIPO} ESGOTO_ABERTO
 Input Text ${INPUT_DESC} Esgoto aberto na via pública.
 Click Button ${BTN_ENVIAR}
 Wait Until Element Is Visible ${MSG_GPS} timeout=5s
 Element Text Should Contain ${MSG_GPS} Localização obrigatória

 CT03 - Deve bloquear envio sem descrição
 Go To ${URL_REPORTAR}
 Wait Until Element Is Visible ${SELECT_TIPO} timeout=5s
 Select From List By Value ${SELECT_TIPO} FALTA_COLETA
 Click Button ${BTN_USAR_GPS}
 Wait Until Element Is Visible id=gpsCapturado timeout=5s
 Click Button ${BTN_ENVIAR}
 Wait Until Element Is Visible ${MSG_DESC} timeout=5s
 Element Text Should Contain ${MSG_DESC} descreva o problema

 ***Keywords ***
 Dado que o usuário está autenticado como Morador
 Open Browser http://localhost:5173/login ${BROWSER}
 Maximize Browser Window
 Input Text id=email claudia@purify.com
 Input Password id=senha Morador@2026
 Click Button id=btnLogin
 Wait Until Element Is Visible id=navLogout timeout=5s

 E fecha o navegador
 Close Browser

## 3. Relatório de Execução de Testes

**Comando de execução utilizado**
`robot reporte_saneamento.robot`

**Ambiente de Testes**

| Item | Valor |
| :--- | :--- |
| Ferramenta | Robot Framework |
| Biblioteca | SeleniumLibrary |
| Navegador | Google Chrome |
| Ambiente | Localhost |
| URL | `http://localhost:5173/reportar` |
| Data de execução | 05/06/2026 |

**Evidências dos Casos de Teste**

| Caso de Teste | Resultado Esperado | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- |
| CT01 - Reporte válido | Mensagem de sucesso exibida | "Reporte enviado com sucesso!" | Aprovado |
| CT02 - Sem GPS | "Localização obrigatória" | "Localização obrigatória para reportar ocorrência." | Aprovado |
| CT03 - Sem descrição | "Descreva o problema" | "Por favor, descreva o problema antes de enviar." | Aprovado |

**Resumo dos Resultados**

| Total de testes | Aprovados | Reprovados |
| :--- | :--- | :--- |
| 3 | 3 | 0 |

**Arquivos de Evidência da Execução**

| Arquivo | Descrição | Link |
| :--- | :--- | :--- |
| report.html | Resumo executivo da execução dos testes | [Abrir report.html](https://github.com/joaochecchia/purify_testes/blob/main/tests/interface/reports/reporte_saneamento/report.html) |
| log.html | Log detalhado da execução dos testes | [Abrir log.html](https://github.com/joaochecchia/purify_testes/blob/main/tests/interface/reports/reporte_saneamento/log.html) |
| output.xml | Resultado bruto da execução dos testes | [Abrir output.xml](https://github.com/joaochecchia/purify_testes/blob/main/tests/interface/reports/reporte_saneamento/output.xml) |

**Conclusão:** Os testes da tela de reporte validaram a obrigatoriedade de localização GPS (RN-007), a validação de descrição (RF-23) e o fluxo de sucesso de registro de ocorrência (RF-24).
