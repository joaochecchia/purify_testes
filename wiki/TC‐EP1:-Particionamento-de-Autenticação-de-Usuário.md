**Responsável:** João Gabriel Brito Checchia

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-11 (Cadastrar Usuários) / RF-12 (Validar dados de cadastro) / HU01

### 1. Regras e Modelagem (EP)

**Variável analisada:** Credenciais de autenticação (e-mail + senha)

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Credenciais válidas | E-mail e senha correspondentes a um usuário cadastrado no banco de dados | Autenticação realizada com sucesso (HTTP 200 + token JWT) |
| P2 | E-mail inexistente | E-mail não cadastrado no sistema | Credenciais inválidas (HTTP 401) |
| P3 | Senha incorreta | E-mail válido, mas senha errada | Credenciais inválidas (HTTP 401) |
| P4 | E-mail formato inválido | E-mail sem @ ou domínio inválido | Erro de validação (HTTP 400) |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | email: "joao@purify.com", senha: "Purify@2026" | P1 | HTTP 200 + token JWT retornado |
| CT2 | email: "inexistente@purify.com", senha: "qualquer" | P2 | HTTP 401 — Credenciais inválidas |
| CT3 | email: "joao@purify.com", senha: "senhaerrada" | P3 | HTTP 401 — Credenciais inválidas |
| CT4 | email: "joaopurify.com", senha: "Purify@2026" | P4 | HTTP 400 — Formato de e-mail inválido |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4).
* Total de partições: 4
* **TC = 4 / 4 = 100%**
