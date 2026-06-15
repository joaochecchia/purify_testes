`Responsável: João Gabriel Brito Checchia`

## 1. Modelagem de Teste de API - Particionamento de Equivalência

**Endpoint:** `GET /alertas?id_regiao={id}`

**Partições de Equivalência — Consulta de Alertas por Região**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Região com alertas ativos | Região com pelo menos 1 alerta não resolvido | Lista de alertas retornada (HTTP 200) |
| P2 | Região sem alertas | Região com dados dentro da normalidade | Lista vazia retornada (HTTP 200, array vazio) |
| P3 | Região inválida | ID de região inexistente | HTTP 404 — Região não encontrada |
| P4 | Sem autenticação | Requisição sem token JWT | HTTP 401 — Não autorizado |

---

## 2. Documentação da API

**Endpoint:** Consulta de Alertas por Região
`GET /alertas?id_regiao={id}`

**Descrição:** Retorna os alertas ativos de qualidade da água para uma região específica.

**Headers:**
* Authorization: Bearer {jwt_token}

**Respostas**

**200 - Alertas encontrados**

    {
      "id_regiao": 1,
      "nome_regiao": "Asa Norte",
      "alertas": [
        {
          "id_alerta": 15,
          "nivel_risco": "CRÍTICO",
          "mensagem": "pH 4.5 detectado — abaixo do limite seguro.",
          "recomendacao": "Água imprópria para consumo.",
          "data_geracao": "2026-06-03T14:30:00Z"
        }
      ]
    }

**200 - Sem alertas**

    {
      "id_regiao": 2,
      "nome_regiao": "Taguatinga",
      "alertas": []
    }

**404 - Região não encontrada**

    {
      "status": "erro",
      "mensagem": "Região não encontrada."
    }

---

## 3. Implementação no Postman

**URL:** `GET http://localhost:3000/alertas?id_regiao=1`

**Caso de Teste 01 - Região com alertas**

*Testes (Postman - Tests):*

    pm.test("Status code deve ser 200", function () {
        pm.response.to.have.status(200);
    });
    pm.test("Lista de alertas não deve ser vazia", function () {
        var json = pm.response.json();
        pm.expect(json.alertas.length).to.be.above(0);
    });
    pm.test("Cada alerta deve ter recomendação", function () {
        var json = pm.response.json();
        json.alertas.forEach(function(alerta) {
            pm.expect(alerta).to.have.property('recomendacao');
        });
    });

**Caso de Teste 02 - Região sem alertas**

*URL:* `GET http://localhost:3000/alertas?id_regiao=2`

*Testes (Postman - Tests):*

    pm.test("Status code deve ser 200", function () {
        pm.response.to.have.status(200);
    });
    pm.test("Lista de alertas deve ser vazia", function () {
        var json = pm.response.json();
        pm.expect(json.alertas).to.be.an('array').that.is.empty;
    });

---

## 4. Relatório de Execução de Testes

**Ambiente de testes:**
* Ferramenta: Postman
* Ambiente: Local (localhost)
* Data de execução: 04/06/2026

| Caso de Teste | Resultado Esperado | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- |
| CT01 - Região com alertas ativos | 200, lista não vazia | 200, lista com 1 alerta | Aprovado |
| CT02 - Região sem alertas | 200, lista vazia | 200, lista vazia | Aprovado |
| CT03 - Região inválida | 404 | 404 | Aprovado |
| CT04 - Sem autenticação | 401 | 401 | Aprovado |

| Total de testes | Aprovados | Reprovados |
| :--- | :--- | :--- |
| 4 | 4 | 0 |
