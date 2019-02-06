IMAGE_VERSION		:= $(shell git name-rev --tags --name-only $$(git rev-parse HEAD))
BUILD_DATE		:= $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
VCS_REF			:= $(shell git rev-parse --short HEAD)
STACK_NAME		:= $(shell basename "$$(pwd)")

DOMAINNAME		:= testnet.dapla.net
VIRTUAL_HOST		:= radio.$(DOMAINNAME)
ENVIRONMENT		:= production
IMAGE_NAME		:= dallasmakerspace/livestream:$(IMAGE_VERSION)

export ENVIRONMENT 
export IMAGE_NAME

.PHONY: all clean deploy test $(VIRTUAL_HOST)
.DEFAULT: all

all: clean deploy

clean:
	@docker stack rm $(STACK_NAME)

distclean: clean
	@docker volume ls | awk '/$(STACK_NAME)/ { system("docker volume rm "$$2) }'

deploy: image
	@docker stack deploy -c docker-compose.yml $(STACK_NAME)

test: $(VIRTUAL_HOST)

image:
	@echo "building version - $(IMAGE_VERSION)"
	@docker image build \
		--build-arg VCS_REF=$(VCS_REF) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--build-arg VERSION=$(IMAGE_VERSION) \
		-t $(IMAGE_NAME) .

$(VIRTUAL_HOST):
	@curl -sSLk $@
