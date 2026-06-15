**Responsável:** Daniel Souza

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-19 (Controle de acesso) / RN-003 / F02

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O usuário está autenticado (token JWT válido)?
2. O perfil do usuário é ONG ou Governante?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| Autenticado? | Sim | Sim | Não | Não |
| Perfil ONG/Gov.? | Sim | Não | Sim | Não |
| **Ação (Saída)** | PERMITIR | NEGAR (403) | NEGAR (401) | NEGAR (401) |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | Token válido de usuário ONG — POST /dados-tecnicos | R1 | HTTP 200 — Registro criado com sucesso. |
| CT2 | Token válido de usuário Morador — POST /dados-tecnicos | R2 | HTTP 403 — Acesso negado. |
| CT3 | Sem token — POST /dados-tecnicos | R3 | HTTP 401 — Não autorizado. |
| CT4 | Token inválido (expirado) — POST /dados-tecnicos | R4 | HTTP 401 — Não autorizado. |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
