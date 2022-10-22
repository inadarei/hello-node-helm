default: start logs

service:=ms-hello-python
project:=ms-workspace-demo


.PHONY: helm-publish
helm-publish:
	helm pakage helm-src -d charts/
	helm repo index charts/

.PHONY: start
start:
	docker-compose -p ${project} up -d

.PHONY: stop
stop:
	docker-compose -p ${project} down

.PHONY: restart
restart: stop start

.PHONY: ps
ps:
	docker-compose -p ${project} ps

.PHONY: logs
logs:
	docker-compose -p ${project} logs -f

.PHONY: logs-db
logs-db:
	docker-compose -p ${project} logs -f ms-redis

.PHONY: logs-app
logs-app:
	docker-compose -p ${project} logs -f ${service}

# connect to redis cli for debugging
.PHONY: redis
redis:
	docker-compose -p ${project} exec ms-redis redis-cli -a 4n_ins3cure_P4ss

# connect to the microservice cli for debugging
.PHONY: shell
shell:
	docker-compose -p ${project} exec ${service} bash

.PHONY: build
build:
	docker-compose -p ${project} build --no-cache

.PHONY: build-multiplatform-publish
build-multiplatform-publish:
	docker buildx build --no-cache --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --platform linux/amd64,linux/arm64,linux/arm/v7 -t ${DOCKER_USER}/${service}:latest --push .

.PHONY: clean
clean: stop build start

.PHONY: install-package-in-container
install-package-in-container:
	docker-compose -p ${project} exec ${service} pip install ${package}
	docker-compose -p ${project} exec ${service} pip freeze > requirements.txt

.PHONY: add
add: start install-package-in-container build

.PHONY: deps
deps:
	docker-compose -p ${project} exec ${service} pip install -r requirements.txt

.PHONY: lint
lint:
	docker-compose -p ${project} exec ${service} pylint service.py src/*.py tests/**/*.py

.PHONY: test
test: start test-run-only

.PHONY: test-run-only
test-run-only:
	docker-compose -p ${project} exec ${service} pytest
