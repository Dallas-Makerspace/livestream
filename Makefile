ifeq ($(OS),Windows_NT)
OPEN := start

else

ifeq ($(shell uname -s),Linux)
OPEN := xdg-open
endif

ifeq ($(shell uname -s),Darwin)
OPEN := open
endif

endif

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
export VIRTUAL_HOST

.PHONY: all clean deploy test $(VIRTUAL_HOST)
.DEFAULT: all

all: clean deploy

clean:
	@docker stack rm $(STACK_NAME)

distclean: clean
	@docker volume ls | awk '/$(STACK_NAME)/ { system("docker volume rm "$$2) }'
	@docker image rm $(IMAGE_NAME)
	@docker system prune -f

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


launch:
	@$(OPEN) $(VIRTUAL_HOST)

$(VIRTUAL_HOST):
	@curl -sSLk $@
