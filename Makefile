.PHONY: build clean tool lint help

all: build

build:
	go build -v .

tool:
	go vet ./...; true
	gofmt -w .

lint:
	golint ./...

clean:
	rm -rf go-boilerplate-api
	go clean -i .

logs:
	docker-compose logs -f

docker-clean: down
	@echo "=============Cleaning Up============="
	rm -f go-boilerplate-api
	docker system prune -f
	docker volume prune -f

default:
	@echo "=============Restoring Dependencies============="
	go get -u github.com/kardianos/govendor
	govendor sync

	@echo "=============Building Swagger Docs============="
	go get -u github.com/swaggo/swag/cmd/swag
	swag init

	@echo "=============Building API Dockerfile============="
	docker build -f ./Dockerfile -t go-boilerplate-api .

up: default
	@echo "=============starting api locally============="
	docker-compose up -d
	make logs

down:
	docker-compose down

help:
	@echo "make: compile packages and dependencies"
	@echo "make tool: run specified go tool"
	@echo "make lint: golint ./..."
	@echo "make clean: remove object files and cached files"
