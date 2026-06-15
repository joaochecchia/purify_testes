**Responsável:** Victor Davidson

**Técnica:** Partição de Equivalência (EP)

**Rastreabilidade:** RF-15 (Selecionar região para consulta) / RN-002 / F18

### 1. Regras e Modelagem (EP)

**Variável analisada:** Status da região selecionada para consulta de qualidade ou saneamento

**Partições de Equivalência:**

| Índice | Partição | Descrição | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| P1 | Região disponível com dados | Região com ao menos 1 registro ativo | Dashboard exibido com dados de qualidade/saneamento |
| P2 | Região disponível sem dados recentes | Região existe mas sem dados nas últimas 24h | Dados mais antigos exibidos com aviso de desatualização |
| P3 | Região indisponível | Região sem nenhum registro histórico | Marcada como "Indisponível" no mapa; mensagem exibida |
| P4 | Pesquisa com texto inválido | Busca com menos de 3 caracteres | Sem sugestões; mensagem de mínimo de caracteres |

### 2. Execução do Teste

| CT | Dados de Entrada | Cobre | Resultado Esperado |
| :--- | :--- | :--- | :--- |
| CT1 | Seleção da região "Asa Norte" (com dados nas últimas 24h) | P1 | Dashboard com pH, turbidez e IQA exibidos. |
| CT2 | Seleção da região "Samambaia" (último dado há 5 dias) | P2 | Dashboard com dados mais antigos + aviso "Dados de X dias atrás." |
| CT3 | Seleção da região "Zona Rural Nova" (sem registros) | P3 | Região marcada "Indisponível"; "Não há dados para esta região." |
| CT4 | Digitação "As" no campo de pesquisa | P4 | Sem sugestões; "Digite ao menos 3 caracteres para pesquisar." |

### 3. Taxa de Cobertura (TC)

* Partições testadas: P1 (CT1), P2 (CT2), P3 (CT3), P4 (CT4).
* Total de partições: 4
* **TC = 4 / 4 = 100%**
