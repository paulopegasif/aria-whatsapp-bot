# 📘 Documentação Técnica

## Fluxo de Agendamento --- Clínica Aria

Baseado no fluxo atual: `Ar.Ia - Agendamento Clínica`

------------------------------------------------------------------------

# 1️⃣ CONTEXTO DO FLUXO ATUAL

O fluxo é dividido em 4 grandes jornadas:

1.  **Agendamento**
2.  **Cancelamento**
3.  **Reagendamento**
4.  **Tirar Dúvidas (Atendimento Geral)**

Estrutura principal:

Menu Inicial\
↓\
Escolha do usuário\
↓\
Triagem (OpenAI - Node 21)\
↓\
Verificação de horários (API Node 9)\
↓\
Apresentação de horários (Node 26)\
↓\
Confirmação (Node 27)\
↓\
Agendamento (Node 33)\
↓\
Confirmação final (Node 35)

------------------------------------------------------------------------

# 2️⃣ PROBLEMAS IDENTIFICADOS

## Transferência Humana Excessiva

Diversos condicionais enviam direto para humano em caso de erro
inesperado.

Impacto: - Sobrecarga de atendimento humano - Perda de automação -
Experiência instável

------------------------------------------------------------------------

## Falta de Revalidação Automática

Hoje:

Erro API → Humano

Deveria ser:

Erro API → Retry automático → Se falhar novamente → Humano

------------------------------------------------------------------------

## Mensagem Técnica Inadequada

Mensagem atual menciona "problema no sistema", gerando insegurança.

------------------------------------------------------------------------

# 3️⃣ ARQUITETURA PROPOSTA

Implementação de 4 camadas:

1.  Camada Conversacional (GPT)
2.  Camada de Validação (Conditional)
3.  Camada de Retry Automático
4.  Transferência Humana Estratégica

------------------------------------------------------------------------

# 4️⃣ MODIFICAÇÕES DETALHADAS

------------------------------------------------------------------------

## BLOCO 1 --- Verificação de Horários

Atual:

Node 11 → Node 9\
Node 9 → Node 29

29.1 → Node 26\
29.2 → Node 30\
29.3 → Node 24

### Modificação

Inserir após 29.3:

Retry_Verificacao_Message\
Mensagem:\
"Estou validando novamente os horários para garantir a disponibilidade."

Retry_Verificacao_API\
(Duplicar Node 9)

Retry_Verificacao_Conditional

Se success == true → Node 26\
Se success == false → Transferência Humana

------------------------------------------------------------------------

## BLOCO 2 --- Agendamento Final

Atual:

Node 33 → Node 34

34.1 → Node 35\
34.2 → Node 36\
34.3 → Node 36

### Modificação

Antes de Node 36:

Revalidar_Disponibilidade_Message\
"Vou verificar novamente os horários disponíveis."

Revalidar_Disponibilidade_API

Se houver horários → Node 26\
Se não houver → Node 36

------------------------------------------------------------------------

## BLOCO 3 --- Reagendamento

Atual:

Node 67 → Node 70

70.1 → Node 68\
70.2 → Node 71

### Modificação

Antes de Node 71:

Retry_Reagendamento_Message\
"Vou validar novamente o reagendamento."

Retry_Reagendamento_API

Se success == true → Node 68\
Se false → Node 71

------------------------------------------------------------------------

## BLOCO 4 --- Transferência Humana Estratégica

Substituir mensagem atual por:

"Vou direcionar você para um dos nossos atendentes para finalizar isso
com segurança."

Sem mencionar erro técnico.

------------------------------------------------------------------------

# 5️⃣ RESULTADO ESPERADO

-   Redução de transferências humanas
-   Maior robustez contra falhas
-   Melhor experiência conversacional
-   Estrutura escalável e profissional

------------------------------------------------------------------------

Documento gerado para organização técnica do fluxo de produção.
