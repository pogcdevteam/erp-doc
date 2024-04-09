serve:
	docker compose -f docker-compose.dev.yml up

down-development:
	docker compose -f docker-compose.dev.yml down

build:
	docker exec -it erp-docs mkdocs  build --config-file ./en/mkdocs.yml --site-dir ../docs
