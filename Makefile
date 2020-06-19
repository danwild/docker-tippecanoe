
TAG=1.35.0
IMAGE=docker-registry.it.csiro.au/etas/tippecanoe:$(TAG)

build:
	docker build -t $(IMAGE) .

push: build
	docker push $(IMAGE)

run:
	docker run -it -v $(PWD):/home/tippecanoe $(IMAGE)