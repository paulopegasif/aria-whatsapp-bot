.PHONY: up down tunnel n8n

ifneq (,$(wildcard .env))
include .env
export
endif

check-docker:
	@docker info >/dev/null 2>&1 || (echo "❌ Docker daemon não está ativo. Abra o Docker Desktop e tente novamente." && exit 1)

start-local:
	@docker start n8n-aria aria-ai-service aria-chromadb evolution_api evolution-postgres redis-aria >/dev/null 2>&1 || true

# Nome do tunnel
TUNNEL_NAME=n8n-tunnel

# Porta do n8
N8N_PORT=55000

up: check-docker start-local
	@echo "🚀 Subindo n8n..."
	@docker compose up -d ai-service n8n chromadb evolution-api evolution-postgres redis || (echo "⚠️ Falha no compose. Se os containers já existirem, continuando em modo local." && true)
	@sleep 5
	@echo "🔗 Configurando ioredis para ArIA-Logs..."
	@docker exec --user root n8n-aria sh -c "mkdir -p /home/node/node_modules && ln -sf /usr/local/lib/node_modules/n8n/node_modules/.pnpm/ioredis@5.3.2/node_modules/ioredis /home/node/node_modules/ioredis" 2>/dev/null || true
	@if [ -n "$(CLOUDFLARE_TUNNEL_TOKEN)" ]; then \
		echo "🌍 Subindo Cloudflare Tunnel..."; \
		cloudflared tunnel run $(TUNNEL_NAME); \
	else \
		echo "⚠️ CLOUDFLARE_TUNNEL_TOKEN não definido; pulando tunnel."; \
	fi

n8n: check-docker start-local
	@docker compose up -d ai-service n8n chromadb evolution-api evolution-postgres redis || (echo "⚠️ Falha no compose. Se os containers já existirem, continuando em modo local." && true)
	@sleep 5
	@echo "🔗 Configurando ioredis para ArIA-Logs..."
	@docker exec --user root n8n-aria sh -c "mkdir -p /home/node/node_modules && ln -sf /usr/local/lib/node_modules/n8n/node_modules/.pnpm/ioredis@5.3.2/node_modules/ioredis /home/node/node_modules/ioredis" 2>/dev/null || true

tunnel:
	cloudflared tunnel run $(TUNNEL_NAME)

down:
	docker compose down
