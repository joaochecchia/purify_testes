**Responsável:** João Gabriel Brito Checchia

## 1. Modelagem de Teste de Interface - Tabela de Decisão

**Interface:** Tela de Login (`http://localhost:5173/login`)

**Tabela de Decisão**

| Condição / Regra | CT01 | CT02 | CT03 |
| :--- | :--- | :--- | :--- |
| R1 - E-mail válido cadastrado | S | N | S |
| R2 - Senha correta | S | S | N |
| **Resultado esperado** | Acesso ao dashboard | Credenciais inválidas | Credenciais inválidas |

## 2. Implementação

**Robot Framework com SeleniumLibrary**

**Suite de Teste:** `login.robot`

 ***Settings ***
 Library SeleniumLibrary
 Suite Setup Dado que o usuário acessa a tela de login
 Suite Teardown E fecha o navegador

 ***Variables ***
 ${URL} http://localhost:5173/login
 ${BROWSER} chrome
 ${INPUT_EMAIL} id=email
 ${INPUT_SENHA} id=senha
 ${BTN_LOGIN} id=btnLogin
 ${MENSAGEM_ERRO} id=mensagemErro
 ${NAV_LOGOUT} id=navLogout

 ***Test Cases ***
 CT01 - Deve realizar login com dados válidos
 Dado que o usuario informa o email daniel@purify.com
 E informa a senha Purify@2026
 Quando solicitar o login
 Entao o sistema deve acessar o dashboard
 E o usuario faz logout

 CT02 - Deve exibir erro com e-mail inválido
 [Setup] Go To ${URL}
 Dado que o usuario informa o email naoexiste@purify.com
 E informa a senha Purify@2026
 Quando solicitar o login
 Entao o sistema deve apresentar a mensagem de erro Credenciais inválidas

 CT03 - Deve exibir erro com senha incorreta
 [Setup] Go To ${URL}
 Dado que o usuario informa o email daniel@purify.com
 E informa a senha senhaerrada
 Quando solicitar o login
 Entao o sistema deve apresentar a mensagem de erro Credenciais inválidas

 ***Keywords ***
 Dado que o usuário acessa a tela de login
 Open Browser ${URL} ${BROWSER} options=add_argument("--incognito")
 Maximize Browser Window
 Set Selenium Speed 0.5 seconds

 Dado que o usuario informa o email
 [Arguments] ${email}
 Wait Until Element Is Visible ${INPUT_EMAIL} timeout=5s
 Input Text ${INPUT_EMAIL} ${email}

 E informa a senha
 [Arguments] ${senha}
 Input Password ${INPUT_SENHA} ${senha}

 Quando solicitar o login
 Click Button ${BTN_LOGIN}

 Entao o sistema deve acessar o dashboard
 Wait Until Element Is Visible ${NAV_LOGOUT} timeout=5s

 Entao o sistema deve apresentar a mensagem de erro
 [Arguments] ${mensagem}
 Wait Until Element Is Visible ${MENSAGEM_ERRO} timeout=5s
 Element Text Should Be ${MENSAGEM_ERRO} ${mensagem}

 E o usuario faz logout
 Click Element ${NAV_LOGOUT}
 Wait Until Element Is Visible ${INPUT_EMAIL} timeout=5s

 E fecha o navegador
 Close Browser

## 3. Relatório de Execução de Testes

**Comando de execução utilizado**
`robot login.robot`

**Ambiente de Testes**

| Item | Valor |
| :--- | :--- |
| Ferramenta | Robot Framework |
| Biblioteca | SeleniumLibrary |
| Navegador | Google Chrome |
| Ambiente | Localhost |
| URL | `http://localhost:5173/login` |
| Data de execução | 02/06/2026 |

**Evidências dos Casos de Teste**

| Caso de Teste | Resultado Esperado | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- |
| CT01 - Login válido | Acesso ao dashboard | Acesso ao dashboard | Aprovado |
| CT02 - E-mail inválido | Mensagem: Credenciais inválidas | Mensagem: Credenciais inválidas | Aprovado |
| CT03 - Senha incorreta | Mensagem: Credenciais inválidas | Mensagem: Credenciais inválidas | Aprovado |

**Resumo dos Resultados**

| Total de testes | Aprovados | Reprovados |
| :--- | :--- | :--- |
| 3 | 3 | 0 |

**Conclusão:** Os testes automatizados executados utilizando Robot Framework e SeleniumLibrary apresentaram total conformidade com o comportamento esperado da tela de login do sistema Purify.
