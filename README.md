# 🚀 ARIA WhatsApp Intelligent Lead Bot

Projeto de automação e inteligência artificial para atendimento e
qualificação de leads via WhatsApp utilizando:

-   n8n (orquestração e integrações)
-   Python (motor de inteligência)
-   OpenAI (modelo de linguagem)
-   Docker (infraestrutura containerizada)

------------------------------------------------------------------------

## 🎯 Objetivo

Criar um canal principal de atendimento automatizado capaz de:

-   Responder dúvidas com IA de forma natural
-   Qualificar leads automaticamente
-   Realizar triagens inteligentes
-   Redirecionar contatos para:
    -   Comercial
    -   Financeiro
    -   Pedagógico
-   Reduzir carga operacional do time comercial
-   Escalar atendimento sem aumentar equipe

------------------------------------------------------------------------

## 🏗 Arquitetura

WhatsApp Cloud API ↓ n8n (Webhook & Orquestração) ↓ AI Service (Python /
FastAPI) ↓ n8n ↓ WhatsApp Response

------------------------------------------------------------------------

## 🧠 Estratégia de Implementação

### 🔹 Fase 1 -- MVP Inteligente

-   Agente IA para responder dúvidas
-   Integração via webhook
-   Demonstração executiva

### 🔹 Fase 2 -- Qualificação de Leads

-   Classificação automática de intenção
-   Extração estruturada de informações
-   Score de qualificação

### 🔹 Fase 3 -- Roteamento Inteligente

-   Direcionamento automático por setor
-   Integração com CRM
-   Encaminhamento para humano somente quando necessário

### 🔹 Fase 4 -- Memória Persistente

-   Redis para contexto
-   Histórico por número de telefone
-   Aprendizado contínuo estruturado

------------------------------------------------------------------------

## 📁 Estrutura do Projeto

aria-whatsapp-bot/ │ ├── docker-compose.yml ├── .env ├── README.md ├──
.gitignore │ ├── n8n/ \# Workflows exportados │ └── ai-service/ \#
Microserviço Python ├── app/ │ ├── main.py │ ├── agent.py │ ├──
prompts.py │ └── memory.py ├── requirements.txt └── Dockerfile

------------------------------------------------------------------------

## ⚙️ Tecnologias

-   Docker
-   Docker Compose
-   n8n
-   FastAPI
-   OpenAI API
-   Redis (planejado)
-   PostgreSQL (futuro)

------------------------------------------------------------------------

## 🛠 Setup

### 1️⃣ Clonar repositório

git clone `<repo>`{=html} cd aria-whatsapp-bot

### 2️⃣ Configurar variáveis de ambiente

Criar arquivo `.env`:

OPENAI_API_KEY= WHATSAPP_TOKEN= N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin N8N_BASIC_AUTH_PASSWORD=senha_segura

### 3️⃣ Subir containers

make deploy

ou

docker compose up -d

------------------------------------------------------------------------

## 🤖 MCP no VS Code (Copilot)

O projeto já possui configuração de MCP em `.vscode/mcp.json` com 3 servidores:

-   **`b24-dev-mcp`**: documentação oficial Bitrix24.
-   **`n8n-mcp-vps`**: MCP HTTP do n8n publicado na sua VPS.
-   **`hostinger-api-mcp`**: MCP HTTP da API da Hostinger.

### Inputs esperados no primeiro uso

-   `n8nMcpHttpUrl` e `n8nMcpHttpToken` (para `n8n-mcp-vps`)
-   `hostingerMcpUrl` e `hostingerMcpToken` (para `hostinger-api-mcp`)

### Dica rápida para produção (VPS)

Use HTTPS com domínio próprio e mantenha tokens fora do repositório.

------------------------------------------------------------------------

## 🔐 Segurança

-   Nunca versionar `.env`
-   Nunca subir `n8n_data/`
-   Utilizar autenticação básica no n8n
-   Futuramente adicionar proxy reverso + HTTPS

------------------------------------------------------------------------

## 📌 Status do Projeto

🚧 Em desenvolvimento\
🎯 Atualmente na Fase 1 -- MVP Inteligente

------------------------------------------------------------------------

## 🧩 Visão de Longo Prazo

Transformar o bot em:

-   Canal principal de atendimento
-   Sistema automatizado de qualificação
-   Filtro inteligente de leads
-   Motor de triagem organizacional
-   Plataforma escalável

------------------------------------------------------------------------

## 👨‍💻 Responsável

Projeto desenvolvido para estruturação inteligente de atendimento e
escalabilidade institucional.
