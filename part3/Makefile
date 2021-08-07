.PHONY: usage
usage:
	@echo "Usage: make RULE"
	@echo "Rules are as follows:"
	@grep .PHONY Makefile | grep -v grep | grep -v -w usage | sort | awk '{print "  ", $$2}'
	@exit 1

.PHONY: all
all: /dev/null

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
	if [ ! -z "$$XID" ] ; then docker image rm --force $$XID || exit 1 ; fi

.PHONY: clean-volumes
clean-volumes:
	XID=`docker volume ls -q` ; \
	if [ ! -z "$$XID" ] ; then docker volume rm --force $$XID || exit 1 ; fi

.PHONY: part3.1
part3.1:
	@echo NB: GitHub repository is https://github.com/ptrktn/roomtemp
	@echo NB: Heroku application is https://uhdowc-roomtemp.herokuapp.com
	@echo NB: DockerHub image is https://hub.docker.com/repository/docker/uhdowccourse/roomtemp

.PHONY: part3.2
part3.2:
	cd part3.2 && docker build . -t github2dockerhub
	docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock github2dockerhub https://github.com/ptrktn/roomtemp.git uhdowccourse

.PHONY: test
test:
	for i in `seq 1 8` ; do f=part2.$${i}.txt ; test -f $$f || exit 1 ; echo $$f ; done

.PHONY: clean
clean:
	$(MAKE) stop-containers prune-containers clean-images clean-volumes
	test -z "`docker image ls -q`"
	test -z "`docker container ls -q`"
