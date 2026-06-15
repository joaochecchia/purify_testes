**Responsável:** João Gabriel Brito Checchia

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-12 (Validar dados de cadastro) / RNF-004

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O e-mail informado está cadastrado no sistema?
2. O link de redefinição de senha é válido (não expirado)?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| E-mail cadastrado? | Sim | Sim | Não | Não |
| Link válido? | Sim | Não | Sim | Não |
| **Ação (Saída)** | PERMITIR redefinição | NEGAR — link expirado | Enviar e-mail (não revela existência) | Nenhuma ação |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | E-mail cadastrado + link válido (dentro de 1 hora) | R1 | Tela de nova senha exibida; redefinição permitida. |
| CT2 | E-mail cadastrado + link expirado (mais de 1 hora) | R2 | Mensagem: "Link expirado. Solicite um novo e-mail." |
| CT3 | E-mail não cadastrado — solicitação de recuperação | R3 | Mensagem genérica: "Se o e-mail existir, você receberá um link." (sem revelar cadastro) |
| CT4 | E-mail não cadastrado + link inválido | R4 | Nenhuma ação; página de erro genérico. |

### 3. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
