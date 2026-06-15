**Responsável:** Victor Madeu

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-13 (Garantir unicidade de usuário) / RN-006 / F04

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O e-mail informado já existe no banco de dados?
2. O CPF/CNPJ informado já existe no banco de dados?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| E-mail duplicado? | Sim | Sim | Não | Não |
| CPF/CNPJ duplicado? | Sim | Não | Sim | Não |
| **Ação (Saída)** | BLOQUEAR — ambos duplicados | BLOQUEAR — e-mail duplicado | BLOQUEAR — CPF duplicado | CRIAR conta |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | email=existente; cpf=existente | R1 | HTTP 409 — "E-mail já cadastrado. Faça login ou recupere sua senha." |
| CT2 | email=existente; cpf=novo | R2 | HTTP 409 — "E-mail já cadastrado. Faça login ou recupere sua senha." |
| CT3 | email=novo; cpf=existente | R3 | HTTP 409 — "CPF/CNPJ já vinculado a uma conta existente." |
| CT4 | email=novo; cpf=novo | R4 | HTTP 201 — Conta criada com sucesso. |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
