**Responsável:** João Gabriel Brito Checchia

**Técnica:** Tabela de Decisão (DT)

**Rastreabilidade:** RF-11 (Cadastrar/Excluir usuários) / RN-008 / F20 — LGPD

### 1. Regras e Modelagem (DT)

**Condições de Entrada:**
1. O usuário possui reportes de saneamento registrados?
2. O usuário confirmou a exclusão com dupla autenticação?

**Tabela de Decisão:**

| Regras | R1 | R2 | R3 | R4 |
| :--- | :--- | :--- | :--- | :--- |
| Possui reportes? | Sim | Sim | Não | Não |
| Confirmou exclusão? | Sim | Não | Sim | Não |
| **Ação (Saída)** | Excluir dados pessoais + anonimizar reportes | Cancelar exclusão | Excluir conta sem anonimização adicional | Cancelar exclusão |

**Total de regras identificadas:** 4

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | Usuário com 3 reportes; confirma exclusão com 2FA | R1 | Conta excluída. Dados pessoais removidos. Reportes anonimizados (id_usuario=null). Mensagem: "Sua conta foi excluída com sucesso." |
| CT2 | Usuário com reportes; cancela exclusão | R2 | Exclusão cancelada; conta mantida intacta. |
| CT3 | Usuário sem reportes; confirma exclusão | R3 | Conta excluída. Sem anonimização necessária. |
| CT4 | Usuário sem reportes; não confirma | R4 | Exclusão cancelada. |

### 3. Verificação de Conformidade (LGPD — RN-008)

Após CT1, a verificação no banco de dados deve confirmar:
- Campo `nome`, `email`, `senha`, `cpf_cnpj` da tabela USUARIO: **removidos**
- Tabela OCORRENCIA: registros do usuário mantidos com campo `id_usuario = NULL`

### 4. Taxa de Cobertura (TC)

* Regras testadas: 4 (R1, R2, R3, R4).
* Total de regras da tabela: 4
* **TC = 4 / 4 = 100%**
