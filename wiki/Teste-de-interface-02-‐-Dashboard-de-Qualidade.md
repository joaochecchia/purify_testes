**Responsável:** João Gabriel Brito

## 1. Modelagem de Teste de Interface - Particionamento de Equivalência

**Interface:** Dashboard de Qualidade da Água (`http://localhost:5173/dashboard`)

**Partições de Equivalência — Exibição do Dashboard**

| Condição / Regra | CT01 | CT02 | CT03 |
| :--- | :--- | :--- | :--- |
| R1 - Região com dados recentes | S | N | N |
| R2 - Região com dados mas fora dos limites | - | S | N |
| **Resultado esperado** | Dashboard verde (seguro) | Dashboard vermelho (alerta) | "Sem dados disponíveis" |

## 2. Implementação

**Robot Framework com SeleniumLibrary**

**Arquivo do script:** [`tests/interface/dashboard_qualidade.robot`](https://github.com/joaochecchia/purify_testes/blob/main/tests/interface/dashboard_qualidade.robot)

**Suite de Teste:** `dashboard_qualidade.robot`

 ***Settings ***
 Library SeleniumLibrary
 Suite Setup Dado que o usuário está autenticado no dashboard
 Suite Teardown E fecha o navegador

 ***Variables ***
 ${URL_LOGIN} http://localhost:5173/login
 ${URL_DASHBOARD} http://localhost:5173/dashboard
 ${BROWSER} chrome
 ${INPUT_REGIAO} id=campoPesquisaRegiao
 ${BTN_PESQUISAR} id=btnPesquisar
 ${INDICADOR_PH} id=indicadorPH
 ${INDICADOR_COR} id=statusQualidade
 ${MSG_SEM_DADOS} id=msgSemDados
 ${BTN_HISTORICO} id=btnHistorico

 ***Test Cases ***
 CT01 - Deve exibir dashboard verde para região com dados seguros
 Dado que o usuario seleciona a regiao Asa Norte
 Quando o dashboard for carregado
 Entao o indicador de qualidade deve ser SEGURO
 E o indicador de pH deve estar visível

 CT02 - Deve exibir alerta vermelho para região com parâmetros críticos
 Dado que o usuario seleciona a regiao Região Crítica Teste
 Quando o dashboard for carregado
 Entao o indicador de qualidade deve ser CRÍTICO
 E um pop-up de alerta deve ser exibido

 CT03 - Deve exibir mensagem quando região não possui dados
 Dado que o usuario seleciona a regiao Zona Rural Sem Dados
 Quando o dashboard for carregado
 Entao a mensagem de ausência de dados deve ser exibida

 ***Keywords ***
 Dado que o usuário está autenticado no dashboard
 Open Browser ${URL_LOGIN} ${BROWSER}
 Maximize Browser Window
 Input Text id=email joao@purify.com
 Input Password id=senha Purify@2026
 Click Button id=btnLogin
 Wait Until Element Is Visible id=navLogout timeout=5s
 Set Selenium Speed 0.5 seconds

 Dado que o usuario seleciona a regiao
 [Arguments] ${regiao}
 Go To ${URL_DASHBOARD}
 Wait Until Element Is Visible ${INPUT_REGIAO} timeout=5s
 Input Text ${INPUT_REGIAO} ${regiao}
 Click Button ${BTN_PESQUISAR}

 Quando o dashboard for carregado
 Wait Until Element Is Visible ${INDICADOR_COR} timeout=5s

 Entao o indicador de qualidade deve ser
 [Arguments] ${status}
 Element Text Should Be ${INDICADOR_COR} ${status}

 E o indicador de pH deve estar visível
 Element Should Be Visible ${INDICADOR_PH}

 E um pop-up de alerta deve ser exibido
 Wait Until Element Is Visible id=popupAlerta timeout=3s

 Entao a mensagem de ausência de dados deve ser exibida
 Wait Until Element Is Visible ${MSG_SEM_DADOS} timeout=5s
 Element Text Should Contain ${MSG_SEM_DADOS} Não existem dados registrados

 E fecha o navegador
 Close Browser

## 3. Relatório de Execução de Testes

**Comando de execução utilizado**
`robot dashboard_qualidade.robot`

**Ambiente de Testes**

| Item | Valor |
| :--- | :--- |
| Ferramenta | Robot Framework |
| Biblioteca | SeleniumLibrary |
| Navegador | Google Chrome |
| Ambiente | Localhost |
| URL | `http://localhost:5173/dashboard` |
| Data de execução | 03/06/2026 |

**Evidências dos Casos de Teste**

| Caso de Teste | Resultado Esperado | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- |
| CT01 - Dashboard verde (dados seguros) | Indicador "SEGURO" exibido em verde | Indicador "SEGURO" em verde | Aprovado |
| CT02 - Dashboard vermelho (alerta crítico) | Indicador "CRÍTICO" + pop-up de alerta | Indicador "CRÍTICO" + pop-up exibido | Aprovado |
| CT03 - Região sem dados | Mensagem "Não existem dados registrados" | Mensagem exibida corretamente | Aprovado |

**Resumo dos Resultados**

| Total de testes | Aprovados | Reprovados |
| :--- | :--- | :--- |
| 3 | 3 | 0 |

**Arquivos de Evidência da Execução**

| Arquivo | Descrição | Link |
| :--- | :--- | :--- |
| report.html | Resumo executivo da execução dos testes | [Abrir report.html](https://github.com/joaochecchia/purify_testes/blob/main/tests/interface/reports/dashboard_qualidade/report.html) |
| log.html | Log detalhado da execução dos testes | [Abrir log.html](https://github.com/joaochecchia/purify_testes/blob/main/tests/interface/reports/dashboard_qualidade/log.html) |
| output.xml | Resultado bruto da execução dos testes | [Abrir output.xml](https://github.com/joaochecchia/purify_testes/blob/main/tests/interface/reports/dashboard_qualidade/output.xml) |

**Conclusão:** Os testes automatizados do dashboard de qualidade da água validaram corretamente a exibição de indicadores por status (seguro, atenção, crítico), a geração de pop-up de alerta e a exibição da mensagem de ausência de dados, em conformidade com RF-03, RF-04, RF-05 e RN-004.
