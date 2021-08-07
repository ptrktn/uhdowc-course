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

material-applications:
	git clone git@github.com:docker-hy/material-applications.git

.PHONY: part3.1
part3.1:
	@echo NB: GitHub repository is https://github.com/ptrktn/roomtemp
	@echo NB: Heroku application is https://uhdowc-roomtemp.herokuapp.com
	@echo NB: DockerHub image is https://hub.docker.com/repository/docker/uhdowccourse/roomtemp

.PHONY: part3.2
part3.2:
	cd part3.2 && docker build . -t github2dockerhub
	docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock github2dockerhub https://github.com/ptrktn/roomtemp.git uhdowccourse

.PHONY: part3.3
part3.3: material-applications
	install part3.3/Dockerfile.frontend material-applications/example-frontend/Dockerfile
	install part3.3/Dockerfile.backend material-applications/example-backend/Dockerfile
	cd material-applications/example-frontend && docker build . -t example-frontend
	cd material-applications/example-backend && docker build . -t example-backend
	cd part3.3 && docker-compose up -d
	sleep 10
	docker exec -it example-backend pgrep -u appuser -a
	docker exec -it example-frontend pgrep -u appuser -a
	cd part3.3 && docker-compose down

.PHONY: part3.4
part3.4: material-applications
	install part3.4/Dockerfile.frontend material-applications/example-frontend/Dockerfile
	install part3.4/Dockerfile.backend material-applications/example-backend/Dockerfile
	cd material-applications/example-frontend && docker build . -t example-frontend
	cd material-applications/example-backend && docker build . -t example-backend
	docker image ls | grep -w -E '(example-backend|example-frontend)' | awk '{ print $$1, $$(NF) }'
	cd part3.4 && docker-compose up

.PHONY: test
test:
	for i in `seq 1 8` ; do f=part3.$${i}.txt ; test -f $$f || exit 1 ; echo $$f ; done

.PHONY: clean
clean:
	$(MAKE) stop-containers prune-containers clean-images clean-volumes
	test -z "`docker image ls -q`"
	test -z "`docker container ls -q`"
	test -z "`docker image ls -q`"
