.PHONY: usage
usage:
	@echo "Usage: make RULE"
	@echo "Rules are as follows:"
	@grep .PHONY Makefile | grep -v grep | grep -v -w usage | sort | awk '{print "  ", $$2}'
	@exit 1

.PHONY: all
all: part1.1.txt part1.2.txt

material-applications:
	git clone git@github.com:docker-hy/material-applications.git

.PHONY: stop-containers
stop-containers:
	XID=`docker container ls -q` ; \
	if [ ! -z "$$XID" ] ; then docker container stop $$XID || exit 1 ; fi

.PHONY: prune-containers
prune-containers:
	docker container prune --force

.PHONY: clean-images
clean-images:
	XID=`docker image ls -q` ; \
	if [ ! -z "$$XID" ] ; then docker image rm $$XID || exit 1 ; fi

.PHONY: part1.1
part1.1: 
	for i in `seq 3` ; do docker container run -d nginx ; done
	docker container stop `docker container ls -q | head -n 2`
	docker ps -a

.PHONY: part1.2
part1.2:
	docker ps -as
	docker images
	$(MAKE) stop-containers prune-containers clean-images
	docker ps -a
	docker images

.PHONY: part1.3
part1.3:
	docker container run -d --name part1.3 -h part1.3 devopsdockeruh/simple-web-service:ubuntu
	docker logs part1.3
	docker exec -it part1.3 bash

.PHONY: part1.4
part1.4:
	docker container run -it ubuntu sh -c '( apt-get update ; apt-get install -y curl ) > /dev/null 2>&1 ; echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$$website;'

.PHONY: part1.5
part1.5:
	docker pull devopsdockeruh/simple-web-service:ubuntu
	docker pull devopsdockeruh/simple-web-service:alpine
	docker image ls -a
	docker container run -d --name part1.5 -h part1.5 devopsdockeruh/simple-web-service:alpine
	docker exec -it part1.5 sh

.PHONY: part1.6
part1.6:
	@echo Check out https://github.com/docker-hy/docs-exercise/blob/master/index.js
	docker run -it devopsdockeruh/pull_exercise

.PHONY: part1.7
part1.7:
	cd part1.7 && docker build . -t web-server
	docker run web-server

.PHONY: part1.8
part1.8:
	cd part1.8 && docker build . -t curler
	docker run -it curler

.PHONY: part1.9
part1.9:
	touch text.log
	docker run -v "$(PWD)/text.log:/usr/src/app/text.log" devopsdockeruh/simple-web-service:alpine

.PHONY: part1.10
part1.10:
	cd part1.7 && docker build . -t web-server
	docker run -d -p 8080:8080 web-server
	curl http://localhost:8080

.PHONY: part1.11
part1.11: material-applications
	install part1.11/Dockerfile material-applications/spring-example-project
	cd material-applications/spring-example-project && docker build . -t java-spring
	docker run -d -p 8080:8080 java-spring

.PHONY: part1.12
part1.12: material-applications
	install part1.12/Dockerfile material-applications/example-frontend
	cd material-applications/example-frontend && docker build . -t example-frontend
	docker run -d -p 5000:5000 example-frontend

.PHONY: part1.13
part1.13: material-applications
	install part1.13/Dockerfile material-applications/example-backend
	cd material-applications/example-backend && docker build . -t example-backend
	docker run -d -p 8080:8000 example-backend
	sleep 10
	curl http://localhost:8080/ping

.PHONY: part1.14
part1.14:
	$(MAKE) -n part1.12 part1.13

part1.1.txt:
	$(MAKE) stop-containers
	$(MAKE) part1.1 > $@

part1.2.txt:
	$(MAKE) part1.2 > $@

.PHONY: clean
clean:
	$(MAKE) stop-containers prune-containers clean-images
	rm -fr material-applications
	test -z "`docker image ls -q`"
	test -z "`docker container ls -q`"
