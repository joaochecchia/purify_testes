**Responsável:** João Gabriel Brito Checchia

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-11 (Cadastrar usuários) / UC-01

### 1. Regras e Modelagem (EP)

**Variável analisada:** Tipo de perfil selecionado no cadastro

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Perfil Morador | Usuário seleciona "Morador" | Conta criada com permissões de consulta e reporte |
| P2 | Perfil ONG | Usuário seleciona "ONG" | Conta criada com permissões de inserção técnica e consulta |
| P3 | Perfil Governante | Usuário seleciona "Governante" | Conta criada com permissões de inserção técnica e consulta |
| P4 | Perfil inválido | Injeção de perfil não existente no enum ("admin") | HTTP 400 — "Perfil inválido." |
| P5 | Sem perfil selecionado | Campo de perfil não informado | HTTP 400 — "Tipo de perfil é obrigatório." |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | perfil = "MORADOR" | P1 | HTTP 201 — Conta criada; acesso ao dashboard de consulta. |
| CT2 | perfil = "ONG" | P2 | HTTP 201 — Conta criada; acesso ao módulo de inserção técnica. |
| CT3 | perfil = "GOVERNANTE" | P3 | HTTP 201 — Conta criada; acesso ao módulo de inserção técnica. |
| CT4 | perfil = "admin" (inválido) | P4 | HTTP 400 — "Perfil inválido." |
| CT5 | perfil = null | P5 | HTTP 400 — "Tipo de perfil é obrigatório." |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4), P5 (CT5).
* Total de partições: 5
* **TC = 5 / 5 = 100%**
