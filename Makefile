build-production:
	docker compose -f docker-compose.prod.yml build

build-development:
	docker compose -f docker-compose.dev.yml build

run-production:
	docker compose -f docker-compose.prod.yml up

run-development:
	docker compose -f docker-compose.dev.yml up

down-production:
	docker compose -f docker-compose.prod.yml down

down-development:
	docker compose -f docker-compose.dev.yml down


