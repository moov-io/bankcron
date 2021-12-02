PLATFORM=$(shell uname -s | tr '[:upper:]' '[:lower:]')
VERSION := $(shell grep -Eo '(v[0-9]+[\.][0-9]+[\.][0-9]+([-a-zA-Z0-9]*)?)' version.go)

.PHONY: build docker release

build:
	go fmt ./...
	@mkdir -p ./bin/
	go build -o ./bin/bankcron github.com/moov-io/bankcron

clean:
	@rm -rf ./bin/ ./tmp/ coverage.txt misspell* staticcheck lint-project.sh

.PHONY: check
check:
ifeq ($(OS),Windows_NT)
	@echo "Skipping checks on Windows, currently unsupported."
else
	@wget -O lint-project.sh https://raw.githubusercontent.com/moov-io/infra/master/go/lint-project.sh
	@chmod +x ./lint-project.sh
	COVER_THRESHOLD=50.0 time ./lint-project.sh
endif

dist: clean build
ifeq ($(OS),Windows_NT)
	CGO_ENABLED=1 GOOS=windows go build -o bin/bankcron.exe github.com/moov-io/bankcron
else
	CGO_ENABLED=0 GOOS=$(PLATFORM) go build -o bin/bankcron-$(PLATFORM)-amd64 github.com/moov-io/bankcron
endif

docker: clean docker-hub docker-openshift

docker-hub:
	docker build --pull -t moov/bankcron:$(VERSION) -f Dockerfile .
	docker tag moov/bankcron:$(VERSION) moov/bankcron:latest

docker-openshift:
	docker build --pull -t quay.io/moov/bankcron:$(VERSION) -f Dockerfile-openshift --build-arg VERSION=$(VERSION) .
	docker tag quay.io/moov/bankcron:$(VERSION) quay.io/moov/bankcron:latest

release-push:
	docker push moov/bankcron:$(VERSION)
	docker push moov/bankcron:latest

quay-push:
	docker push quay.io/moov/bankcron:$(VERSION)
	docker push quay.io/moov/bankcron:latest
