**Responsável:** João Gabriel Brito Checchia

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-11 (Cadastrar Usuários) / RF-12 (Validar dados de cadastro) / HU01

### 1. Regras e Modelagem (EP)

A técnica de Partição de Equivalência é aplicada separadamente para cada variável de entrada independente do formulário de autenticação.

**Variável 1: E-mail**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| PE1 | E-mail válido e cadastrado | Endereço com formato correto e existente no banco de dados | Prossegue para validação de senha |
| PE2 | E-mail válido, não cadastrado | Endereço com formato correto, mas não registrado no sistema | HTTP 401 — Credenciais inválidas |
| PE3 | E-mail com formato inválido | Ausência de "@", domínio ausente ou caracteres proibidos | HTTP 400 — Formato de e-mail inválido |
| PE4 | E-mail vazio | Campo submetido sem valor | HTTP 400 — Campo obrigatório |

**Variável 2: Senha**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| PS1 | Senha correta | Senha correspondente ao e-mail cadastrado | Autenticação realizada (HTTP 200 + token JWT) |
| PS2 | Senha incorreta | Senha que não corresponde ao e-mail cadastrado | HTTP 401 — Credenciais inválidas |
| PS3 | Senha vazia | Campo submetido sem valor | HTTP 400 — Campo obrigatório |

### 2. Execução do Teste

Os casos de teste combinam as partições das duas variáveis, priorizando a cobertura de todos os grupos relevantes.

| CT | E-mail (entrada) | Senha (entrada) | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- | :--- |
| CT1 | joao@purify.com | Purify@2026 | PE1 + PS1 | HTTP 200 — Token JWT retornado |
| CT2 | inexistente@purify.com | Purify@2026 | PE2 + PS1 | HTTP 401 — Credenciais inválidas |
| CT3 | joao@purify.com | senhaerrada | PE1 + PS2 | HTTP 401 — Credenciais inválidas |
| CT4 | joaopurify.com | Purify@2026 | PE3 | HTTP 400 — Formato de e-mail inválido |
| CT5 | | Purify@2026 | PE4 | HTTP 400 — Campo obrigatório |
| CT6 | joao@purify.com | | PS3 | HTTP 400 — Campo obrigatório |

### 3. Taxa de Cobertura (TC)

* Partições testadas: PE1 (CT1), PE2 (CT2), PE3 (CT4), PE4 (CT5), PS1 (CT1, CT2), PS2 (CT3), PS3 (CT6).
* Total de partições: 7 (PE1 a PE4 + PS1 a PS3)
* **TC = 7 / 7 = 100%**
