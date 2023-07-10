# The commands here have been manually copied into .gitlab-ci.yml because I couldn't figure out
# 	how to run make inside of it

GIT_SHA := $(shell git rev-parse HEAD)

DOCKER_IMAGE_NAME=python-cookie-cutter

install:
	docker build --no-cache -f Dockerfile -t $(DOCKER_IMAGE_NAME) .

test:
	make pep8
	make unittest

dev:
	docker run \
		-v $(PWD)/container/:/opt/container \
		--rm -ti --entrypoint=/bin/bash $(DOCKER_IMAGE_NAME):latest

pep8:
	pip install pre-commit
	pre-commit run --all

unittest:
	docker run \
		-e PYTHONPATH=/opt/container \
		-v $(PWD)/container/:/opt/container \
		$(DOCKER_IMAGE_NAME):latest \
		"poetry run pytest tests/"
run:
	docker run \
		-v $(PWD)/container/:/opt/container \
		$(DOCKER_IMAGE_NAME):latest \
		"poetry run python app.py --learner ${learner} --num-episodes ${num_episodes} --puzzle-type ${puzzle}"

cryptid:
	docker run \
		-v $(PWD)/container/:/opt/container \
		$(DOCKER_IMAGE_NAME):latest \
		"poetry run python app.py --learner sarsa --num-episodes 10 --puzzle-type cryptid"
