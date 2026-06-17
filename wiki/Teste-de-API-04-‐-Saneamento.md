**Responsável:** João Gabriel Brito Checchia

## 1. Modelagem de Teste de API - Particionamento de Equivalência

**Endpoint:** `POST /ocorrencias`

**Partições de Equivalência — Reporte de Problema de Saneamento**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Reporte válido | Tipo, localização GPS e descrição preenchidos | HTTP 201 — Ocorrência registrada |
| P2 | Sem localização | Reporte sem coordenadas GPS | HTTP 400 — Localização obrigatória |
| P3 | Sem descrição | Descrição vazia ou ausente | HTTP 400 — Descrição obrigatória |
| P4 | Sem autenticação | Requisição sem token JWT | HTTP 401 — Não autorizado |

## 2. Documentação da API

**Endpoint:** Reporte de Problema de Saneamento
`POST /ocorrencias`

**Descrição:** Registra um problema de saneamento básico reportado por um morador autenticado, com localização GPS obrigatória (RN-007).

**Headers:**
* Content-Type: application/json
* Authorization: Bearer {jwt_token}

**Body:**

 {
 "tipo_problema": "string (VAZAMENTO | ESGOTO_ABERTO | FALTA_COLETA | OUTRO)",
 "descricao": "string",
 "latitude": "decimal",
 "longitude": "decimal"
 }

**Respostas**

**201 - Ocorrência registrada**

 {
 "status": "sucesso",
 "id_ocorrencia": 88,
 "mensagem": "Reporte enviado com sucesso!"
 }

**400 - Localização ausente**

 {
 "status": "erro",
 "mensagem": "Localização obrigatória para reportar ocorrência."
 }

## 3. Implementação no Postman

**URL:** `POST http://localhost:3000/ocorrencias`

**Caso de Teste 01 - Reporte válido**

*Headers:* Authorization: Bearer {{jwt_token_morador}}

*Body (Request):*

 {
 "tipo_problema": "VAZAMENTO",
 "descricao": "Vazamento de água na calçada da Rua 12, próximo ao número 50.",
 "latitude": -15.7890,
 "longitude": -48.1234
 }

*Testes (Postman - Tests):*

 pm.test("Status code deve ser 201", function () {
 pm.response.to.have.status(201);
 });
 pm.test("Ocorrência deve ter ID gerado", function () {
 var json = pm.response.json();
 pm.expect(json).to.have.property('id_ocorrencia');
 });

**Caso de Teste 02 - Sem localização**

*Body (Request):*

 {
 "tipo_problema": "ESGOTO_ABERTO",
 "descricao": "Esgoto aberto na rua.",
 "latitude": null,
 "longitude": null
 }

*Testes (Postman - Tests):*

 pm.test("Status code deve ser 400", function () {
 pm.response.to.have.status(400);
 });
 pm.test("Mensagem de erro sobre localização", function () {
 var json = pm.response.json();
 pm.expect(json.mensagem).to.include("Localização obrigatória");
 });

## 4. Relatório de Execução de Testes

**Ambiente de testes:**
* Ferramenta: Postman
* Ambiente: Local (localhost)
* Data de execução: 05/06/2026

| Caso de Teste | Resultado Esperado | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- |
| CT01 - Reporte válido | 201, id_ocorrencia retornado | 201, id_ocorrencia: 88 | Aprovado |
| CT02 - Sem localização | 400 — Localização obrigatória | 400 — Localização obrigatória | Aprovado |
| CT03 - Sem descrição | 400 — Descrição obrigatória | 400 — Descrição obrigatória | Aprovado |
| CT04 - Sem autenticação | 401 — Não autorizado | 401 — Não autorizado | Aprovado |

| Total de testes | Aprovados | Reprovados |
| :--- | :--- | :--- |
| 4 | 4 | 0 |

**Conclusão:** O endpoint de reporte de ocorrência validou corretamente a obrigatoriedade de localização GPS (RN-007), a validação de descrição (RF-23) e o controle de autenticação.
