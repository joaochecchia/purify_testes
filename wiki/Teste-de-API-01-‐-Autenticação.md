`Responsável: João Gabriel Brito Checchia`

## 1. Modelagem de Teste de API - Particionamento de Equivalência

**Endpoint:** `POST /auth/login`

**Partições de Equivalência - Credenciais de Acesso**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Credenciais válidas | E-mail e senha correspondentes a um usuário cadastrado | Autenticação realizada com sucesso (HTTP 200 + token JWT) |
| P2 | Credenciais inválidas | E-mail inexistente ou senha incorreta | HTTP 401 — Credenciais inválidas |

**Casos de teste**

**CT01 - Partição P1: Credenciais válidas**

    {
      "email": "daniel@purify.com",
      "senha": "Purify@2026"
    }

*Resultado esperado:* HTTP 200 — Autenticação realizada com sucesso

**CT02 - Partição P2: Credenciais inválidas**

    {
      "email": "daniel@purify.com",
      "senha": "senhaerrada"
    }

*Resultado esperado:* HTTP 401 — Credenciais inválidas

---

## 2. Documentação da API

**Endpoint:** Autenticação de Usuário
`POST /auth/login`

**Descrição:** Valida as credenciais do usuário e retorna o token JWT para acesso ao sistema Purify.

**Requisição**

**Headers:**
* Content-Type: application/json

**Body:**

    {
      "email": "string",
      "senha": "string"
    }

**Respostas**

**200 - Sucesso**

    {
      "status": "sucesso",
      "token": "eyJhbGciOiJIUzI1NiIsIn...",
      "usuario": "João Gabriel",
      "perfil": "ONG"
    }

**401 - Credenciais inválidas**

    {
      "status": "erro",
      "mensagem": "Credenciais inválidas"
    }

---

## 3. Implementação no Postman

**URL:** `POST http://localhost:3000/auth/login`

**Configuração padrão da requisição**
* **Headers:** Content-Type = application/json
* **Autenticação:** Não aplicável (rota pública)

**Caso de Teste 01 - Sucesso**

*Body (Request):*

    {
      "email": "daniel@purify.com",
      "senha": "Purify@2026"
    }

*Testes (Postman - Tests):*

    pm.test("Status code deve ser 200", function () {
        pm.response.to.have.status(200);
    });
    pm.test("Deve retornar um token JWT", function () {
        var json = pm.response.json();
        pm.expect(json).to.have.property('token');
        pm.environment.set("jwt_token", json.token);
    });
    pm.test("Deve retornar o perfil do usuário", function () {
        var json = pm.response.json();
        pm.expect(json).to.have.property('perfil');
    });

**Caso de Teste 02 - Credenciais inválidas**

*Body (Request):*

    {
      "email": "daniel@purify.com",
      "senha": "senhaerrada"
    }

*Testes (Postman - Tests):*

    pm.test("Status code deve ser 401", function () {
        pm.response.to.have.status(401);
    });
    pm.test("Mensagem de erro correta", function () {
        var json = pm.response.json();
        pm.expect(json.mensagem).to.eql("Credenciais inválidas");
    });

---

## 4. Relatório de Execução de Testes

**Endpoint testado:** `POST /auth/login`

**Ambiente de testes:**
* Ferramenta: Postman
* Ambiente: Local (localhost)
* Base URL: http://localhost:3000/
* Data de execução: 02/06/2026

**Casos de Teste e Evidências**

**CT01 - Credenciais válidas**
* Resultado esperado: 200 - Autenticação realizada com sucesso
* Resultado obtido: 200 - Autenticação realizada com sucesso
* Status: Aprovado
* **Evidência (Response Body - Postman):**

      {
          "status": "sucesso",
          "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXV...",
          "usuario": "João Gabriel",
          "perfil": "ONG"
      }

**CT02 - Credenciais inválidas**
* Resultado esperado: 401 - Credenciais inválidas
* Resultado obtido: 401 - Credenciais inválidas
* Status: Aprovado
* **Evidência (Response Body - Postman):**

      {
          "status": "erro",
          "mensagem": "Credenciais inválidas"
      }

**Resumo dos resultados**

| Total de testes | Aprovados | Reprovados |
| :--- | :--- | :--- |
| 2 | 2 | 0 |

**Conclusão:** Os testes executados apresentaram conformidade com o comportamento esperado do endpoint de autenticação, sem divergências entre resultado obtido e resultado esperado.
