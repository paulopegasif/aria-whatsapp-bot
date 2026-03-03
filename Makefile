.PHONY: up down tunnel n8n

# Nome do tunnel
TUNNEL_NAME=n8n-tunnel

# Porta do n8
N8N_PORT=55000

up:
	@echo "🚀 Subindo n8n..."
	docker compose up -d
	@sleep 5
	@echo "🔗 Configurando ioredis para ArIA-Logs..."
	@docker exec --user root n8n-aria sh -c "mkdir -p /home/node/node_modules && ln -sf /usr/local/lib/node_modules/n8n/node_modules/.pnpm/ioredis@5.3.2/node_modules/ioredis /home/node/node_modules/ioredis" 2>/dev/null || true
	@echo "🌍 Subindo Cloudflare Tunnel..."
	cloudflared tunnel run $(TUNNEL_NAME)

n8n:
	docker compose up -d
	@sleep 5
	@echo "🔗 Configurando ioredis para ArIA-Logs..."
	@docker exec --user root n8n-aria sh -c "mkdir -p /home/node/node_modules && ln -sf /usr/local/lib/node_modules/n8n/node_modules/.pnpm/ioredis@5.3.2/node_modules/ioredis /home/node/node_modules/ioredis" 2>/dev/null || true

tunnel:
	cloudflared tunnel run $(TUNNEL_NAME)

down:
	docker compose down
