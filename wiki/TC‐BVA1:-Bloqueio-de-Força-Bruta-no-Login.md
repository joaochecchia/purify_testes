**Responsável:** João Gabriel Brito Checchia

**Técnica:** Análise de Valor de Borda (BVA2)

**Rastreabilidade:** F01 (Permite infinitas tentativas erradas de login — Brute Force)

### 1. Regras e Modelagem (BVA2)

**Regra:** O sistema bloqueia o acesso após mais de 5 tentativas erradas consecutivas de login. Definimos o limite técnico do domínio como 99 tentativas (para fins de partição).

**Domínio:** 0 ≤ tentativas ≤ 99 (Inteiros).

**Partições:**

* P1 (Permitido): 0 ≤ tentativas ≤ 5
* P2 (Bloqueado): 6 ≤ tentativas ≤ 99

**Identificação das Bordas:**

* B1 = {0} (Borda que inicia a primeira partição — solitária)
* B2 = {5, 6} (Transição P1 → P2)
* B3 = {99} (Borda que encerra a última partição — solitária)

**Total de bordas identificadas:** 3

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | tentativas = 0 | B1 | Acesso à tela de login normal sem restrição. |
| CT2 | tentativas = 5 | B2 | Login rejeitado por senha errada, mas IP não bloqueado. |
| CT3 | tentativas = 6 | B2 | IP bloqueado (HTTP 429 Too Many Requests). |
| CT4 | tentativas = 99 | B3 | IP continua bloqueado; mensagem de bloqueio exibida. |

### 3. Taxa de Cobertura (TC)

* Bordas testadas completas: B1 (CT1), B2 (CT2 e CT3), B3 (CT4).
* Total de bordas testadas: 3
* **TC = 3 / 3 = 100%**
