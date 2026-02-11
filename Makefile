deploy:
	docker compose down && docker compose up -d
networks:
	- aria-network