> O projeto **Purify** é um sistema de monitoramento da qualidade da água desenvolvido no contexto da disciplina de Requisitos de Software da Universidade Católica de Brasília. O sistema integra sensores IoT a uma plataforma móvel para coletar, validar e exibir dados de parâmetros hídricos — como pH, turbidez e coliformes — em tempo real, alertando moradores e autoridades sobre condições de risco. A ausência de acesso imediato a informações sobre a qualidade da água é uma preocupação crescente no Distrito Federal. Sem um sistema eficaz de monitoramento, é difícil detectar e responder prontamente a eventos de contaminação, colocando em risco a saúde pública e o meio ambiente.

---

## **OBJETIVO GERAL**

O objetivo do projeto é desenvolver um sistema confiável e acessível de **monitoramento da qualidade da água** para o Distrito Federal, permitindo que moradores, ONGs e órgãos governamentais acompanhem em tempo real os indicadores hídricos de suas regiões — como pH, turbidez e presença de coliformes — e sejam alertados automaticamente quando os parâmetros ultrapassarem os limites seguros estabelecidos pela Portaria GM/MS nº 888/2021 do Ministério da Saúde.

O sistema tem como finalidade reduzir o tempo de resposta a incidentes de contaminação, aumentar a transparência sobre a saúde dos recursos hídricos e facilitar a tomada de decisões informadas por parte de autoridades reguladoras e da população em geral.

Além disso, o projeto busca priorizar **qualidade de software e testabilidade**, adotando uma arquitetura que permita a criação de testes automatizados para validar as regras de negócio relacionadas ao monitoramento hídrico.

---

## **OBJETIVOS ESPECÍFICOS**

Os objetivos específicos do sistema são:

* Integrar **sensores IoT** instalados em campo para coleta contínua de dados de pH, turbidez, temperatura e coliformes em corpos d'água do Distrito Federal.

* Permitir que **usuários técnicos** (ONG/Governante) registrem e atualizem indicadores oficiais de qualidade da água e saneamento por região.

* Disponibilizar um **dashboard interativo** com indicadores coloridos (Verde/Amarelo/Vermelho) para que moradores visualizem a situação hídrica de sua localidade.

* Gerar **alertas automáticos** quando os indicadores ultrapassarem os limites seguros (pH < 6,0 ou > 9,5; turbidez > 40 NTU; coliformes > 0 UFC/100ml), com notificação push para moradores e autoridades.

* Manter um **histórico de dados** ordenado cronologicamente por região, permitindo análise temporal da qualidade da água.

* Permitir que **moradores autenticados** reportem problemas de saneamento básico (vazamentos, esgoto aberto, falta de coleta) com localização geográfica obrigatória via GPS.

* Disponibilizar **dados públicos** de qualidade hídrica e saneamento para consulta por qualquer usuário autenticado.

* Garantir a **conformidade com a LGPD**, implementando anonimização de dados pessoais na exclusão de conta, criptografia em trânsito (TLS 1.3) e em repouso (AES-256).

* Garantir que as regras de negócio do sistema sejam **facilmente testáveis**, permitindo a implementação de testes automatizados para validar o funcionamento das funcionalidades principais.
