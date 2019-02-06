STACK_NAME		:= $(shell basename "$$(pwd)")
DOMAINNAME		:= testnet.dapla.net
VIRTUAL_HOST		:= radio.$(DOMAINNAME)
ENVIRONMENT		:= production
IMAGE_NAME		:= dallasmakerspace/livestream:1.0.2

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
	@docker image build -t $(IMAGE_NAME) .

$(VIRTUAL_HOST):
	@curl -sSLk $@
