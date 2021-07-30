.PHONY: usage
usage:
	@echo "Usage: make RULE"
	@echo "Rules are as follows:"
	@grep .PHONY Makefile | grep -v grep | grep -v -w usage | sort | awk '{print "  ", $$2}'
	@exit 1

.PHONY: all
all: part1.1.txt part1.2.txt

.PHONY: allx
allx:
	docker container run hello-world
	docker container run hello-world
	docker image ls
	docker container ls
	docker container ls -a
	docker container rm `docker container ls -a | sed 1d | awk '{print $$1}'`
	docker container ls -a
	docker image rm hello-world 
	docker image ls

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

part1.1.txt:
	$(MAKE) stop-containers
	$(MAKE) part1.1 > $@

part1.2.txt:
	$(MAKE) part1.2 > $@

.PHONY: clean
clean:
	$(MAKE) stop-containers prune-containers clean-images
	test -z "`docker image ls -q`"
	test -z "`docker container ls -q`"
