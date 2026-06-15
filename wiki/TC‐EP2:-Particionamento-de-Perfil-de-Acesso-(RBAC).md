**Responsável:** Daniel Souza

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-19 (Restringir registro a usuários autorizados) / RN-003 / F02

### 1. Regras e Modelagem (EP)

**Variável analisada:** Perfil do usuário autenticado ao tentar acessar rota de inserção técnica de dados

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Perfil ONG | Usuário autenticado com perfil "ONG" | Acesso permitido à inserção de dados técnicos (HTTP 200) |
| P2 | Perfil Governante | Usuário autenticado com perfil "Governante" | Acesso permitido à inserção de dados técnicos (HTTP 200) |
| P3 | Perfil Morador | Usuário autenticado com perfil "Morador" | Acesso negado (HTTP 403 Forbidden) |
| P4 | Sem autenticação | Requisição sem token JWT | Acesso negado (HTTP 401 Unauthorized) |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | Token de usuário com perfil "ONG" | P1 | HTTP 200 — Dados registrados com sucesso |
| CT2 | Token de usuário com perfil "Governante" | P2 | HTTP 200 — Dados registrados com sucesso |
| CT3 | Token de usuário com perfil "Morador" | P3 | HTTP 403 — Acesso negado |
| CT4 | Nenhum token no header Authorization | P4 | HTTP 401 — Não autorizado |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4).
* Total de partições: 4
* **TC = 4 / 4 = 100%**
