**Responsável:** João Gabriel Brito

## 1. Modelagem de Teste de API - Tabela de Decisão

**Endpoint:** `POST /qualidade-agua`

**Tabela de Decisão — Validação e Persistência de Dados Hídricos**

| Condição / Regra | CT01 | CT02 | CT03 |
| :--- | :--- | :--- | :--- |
| R1 - Perfil autorizado (ONG/Gov.) | S | N | S |
| R2 - Dados válidos (pH, turbidez, coliformes) | S | S | N |
| **Resultado esperado** | Dados salvos (201) | Acesso negado (403) | Dados rejeitados (400) |

## 2. Documentação da API

**Endpoint:** Registro de Dados de Qualidade da Água
`POST /qualidade-agua`

**Descrição:** Registra os indicadores hídricos (pH, turbidez e coliformes) de uma região. Disponível apenas para perfis ONG e Governante.

**Requisição**

**Headers:**
* Content-Type: application/json
* Authorization: Bearer {jwt_token}

**Body:**

 {
 "id_regiao": "integer",
 "ph": "decimal",
 "turbidez": "decimal",
 "coliformes": "decimal"
 }

**Respostas**

**201 - Criado com sucesso**

 {
 "status": "sucesso",
 "id_qualidade": 42,
 "alerta_gerado": false,
 "mensagem": "Dados registrados com sucesso."
 }

**201 - Criado com alerta**

 {
 "status": "sucesso",
 "id_qualidade": 43,
 "alerta_gerado": true,
 "nivel_risco": "CRÍTICO",
 "recomendacao": "Água imprópria para consumo."
 }

**400 - Dados inválidos**

 {
 "status": "erro",
 "mensagem": "Valor de pH inválido. Informe um valor entre 0 e 14."
 }

**403 - Acesso negado**

 {
 "status": "erro",
 "mensagem": "Acesso negado: Perfil não autorizado para registro técnico."
 }

## 3. Implementação no Postman

**URL:** `POST http://localhost:3000/qualidade-agua`

**Caso de Teste 01 - Dados válidos, perfil autorizado, sem alerta**

*Headers:* Authorization: Bearer {{jwt_token_ong}}

*Body (Request):*

 {
 "id_regiao": 1,
 "ph": 7.2,
 "turbidez": 10.0,
 "coliformes": 0.0
 }

*Testes (Postman - Tests):*

 pm.test("Status code deve ser 201", function () {
 pm.response.to.have.status(201);
 });
 pm.test("Nenhum alerta deve ser gerado", function () {
 var json = pm.response.json();
 pm.expect(json.alerta_gerado).to.be.false;
 });

**Caso de Teste 02 - Dados válidos com alerta crítico (pH ácido)**

*Headers:* Authorization: Bearer {{jwt_token_ong}}

*Body (Request):*

 {
 "id_regiao": 1,
 "ph": 4.5,
 "turbidez": 80.0,
 "coliformes": 15.0
 }

*Testes (Postman - Tests):*

 pm.test("Status code deve ser 201", function () {
 pm.response.to.have.status(201);
 });
 pm.test("Alerta deve ser gerado", function () {
 var json = pm.response.json();
 pm.expect(json.alerta_gerado).to.be.true;
 });
 pm.test("Recomendação deve estar presente", function () {
 var json = pm.response.json();
 pm.expect(json).to.have.property('recomendacao');
 });

**Caso de Teste 03 - pH inválido (negativo)**

*Headers:* Authorization: Bearer {{jwt_token_ong}}

*Body (Request):*

 {
 "id_regiao": 1,
 "ph": -2.0,
 "turbidez": 10.0,
 "coliformes": 0.0
 }

*Testes (Postman - Tests):*

 pm.test("Status code deve ser 400", function () {
 pm.response.to.have.status(400);
 });
 pm.test("Mensagem de erro correta", function () {
 var json = pm.response.json();
 pm.expect(json.mensagem).to.include("pH inválido");
 });

**Caso de Teste 04 - Acesso por perfil Morador**

*Headers:* Authorization: Bearer {{jwt_token_morador}}

*Body (Request):*

 {
 "id_regiao": 1,
 "ph": 7.2,
 "turbidez": 10.0,
 "coliformes": 0.0
 }

*Testes (Postman - Tests):*

 pm.test("Status code deve ser 403", function () {
 pm.response.to.have.status(403);
 });

## 4. Relatório de Execução de Testes

**Endpoint testado:** `POST /qualidade-agua`

**Ambiente de testes:**
* Ferramenta: Postman
* Ambiente: Local (localhost)
* Base URL: http://localhost:3000/
* Data de execução: 03/06/2026

**Casos de Teste e Evidências**

| Caso de Teste | Resultado Esperado | Resultado Obtido | Status |
| :--- | :--- | :--- | :--- |
| CT01 - Dados válidos sem alerta | 201, alerta_gerado: false | 201, alerta_gerado: false | Aprovado |
| CT02 - pH crítico com alerta | 201, alerta_gerado: true | 201, alerta_gerado: true | Aprovado |
| CT03 - pH negativo | 400 — pH inválido | 400 — pH inválido | Aprovado |
| CT04 - Acesso por Morador | 403 — Acesso negado | 403 — Acesso negado | Aprovado |

**Resumo dos Resultados**

| Total de testes | Aprovados | Reprovados |
| :--- | :--- | :--- |
| 4 | 4 | 0 |

**Conclusão:** Os testes executados apresentaram total conformidade com o comportamento esperado do endpoint de registro de qualidade da água, validando corretamente o controle de acesso por perfil (RN-003), a rejeição de dados inválidos (RF-02) e a geração correta de alertas (RN-004).
