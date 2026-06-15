**Responsável:** Victor Madeu

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-12 (Validar dados de cadastro) / RN-006

### 1. Regras e Modelagem (EP)

**Variável analisada:** Documento de identificação informado no cadastro (CPF para Morador; CNPJ para ONG/Governante)

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | CPF válido | 11 dígitos com dígitos verificadores corretos | Cadastro aceito como Morador |
| P2 | CNPJ válido | 14 dígitos com dígitos verificadores corretos | Cadastro aceito como ONG/Governante |
| P3 | CPF inválido — dígitos verificadores errados | Sequência com 11 dígitos mas DV inválido | HTTP 400 — "CPF inválido." |
| P4 | CNPJ inválido — formato incorreto | Menos de 14 dígitos ou DV errado | HTTP 400 — "CNPJ inválido." |
| P5 | Documento em branco | Campo não preenchido | HTTP 400 — "Documento é obrigatório." |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | cpf = "529.982.247-25" (válido) | P1 | HTTP 201 — Cadastro como Morador. |
| CT2 | cnpj = "11.222.333/0001-81" (válido) | P2 | HTTP 201 — Cadastro como ONG. |
| CT3 | cpf = "111.111.111-11" (DV inválido) | P3 | HTTP 400 — "CPF inválido." |
| CT4 | cnpj = "12.345.678/0001-00" (DV inválido) | P4 | HTTP 400 — "CNPJ inválido." |
| CT5 | documento = "" (vazio) | P5 | HTTP 400 — "Documento é obrigatório." |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4), P5 (CT5).
* Total de partições: 5
* **TC = 5 / 5 = 100%**
