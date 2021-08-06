.PHONY: usage
usage:
	@echo "Usage: make RULE"
	@echo "Rules are as follows:"
	@grep .PHONY Makefile | grep -v grep | grep -v -w usage | sort | awk '{print "  ", $$2}'
	@exit 1

.PHONY: all
all: /dev/null

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
	if [ ! -z "$$XID" ] ; then docker image rm --force $$XID || exit 1 ; fi

.PHONY: clean-volumes
clean-volumes:
	XID=`docker volume ls -q` ; \
	if [ ! -z "$$XID" ] ; then docker volume rm --force $$XID || exit 1 ; fi

.PHONY: part2.1
part2.1:
	install /dev/null part2.1/text.log
	cd part2.1 && docker-compose up

.PHONY: part2.2
part2.2:
	cd part2.2 && docker-compose up -d
	sleep 10
	curl -s http://localhost:8888

.PHONY: part2.3
part2.3:
	for i in front back ; do \
          docker image ls example-$${i}end || exit 1 ; \
          test -z "`docker ps | grep example-$${i}end`" || exit 1 ; \
        done
	cd part2.3 && docker-compose up -d
	sleep 10
	$(MAKE) -C ../part1 part1.14

.PHONY: part2.4
part2.4:
	for i in front back ; do \
          docker image ls example-$${i}end || exit 1 ; \
          test -z "`docker ps | grep example-$${i}end`" || exit 1 ; \
        done
	cd part2.3 && docker-compose down
	docker pull redis
	cd part2.4 && docker-compose up -d
	sleep 10
	$(MAKE) -C ../part1 part1.14
	test "pong" = "`curl -s 'http://localhost:8080/ping?redis=true'`" && echo SUCCESS

.PHONY: part2.5
part2.5:
	$(MAKE) -C ../part1 material-applications
	cd ../part1/material-applications/scaling-exercise && docker-compose down
	cd ../part1/material-applications/scaling-exercise && docker-compose up -d --scale compute=2

.PHONY: part2.6
part2.6:
	for i in front back ; do \
          docker image ls example-$${i}end || exit 1 ; \
          test -z "`docker ps | grep example-$${i}end`" || exit 1 ; \
        done
	cd part2.4 && docker-compose down
	cd part2.6 && docker-compose up -d
	sleep 10
	$(MAKE) -C ../part1 part1.14
	test "pong" = "`curl -s 'http://localhost:8080/ping?redis=true'`" && echo SUCCESS

ml-kurkkumopo-backend  ml-kurkkumopo-frontend  ml-kurkkumopo-training:
	git clone git@github.com:docker-hy/$@.git

.PHONY: part2.7
part2.7: ml-kurkkumopo-backend  ml-kurkkumopo-frontend  ml-kurkkumopo-training
	for i in ml-kurkkumopo-backend ml-kurkkumopo-frontend ml-kurkkumopo-training ; do (cd $$i && docker build . -t $$i ) || exit 1 ; done
	install -m 755 -d part2.7/src/model
	install -m 755 -d part2.7/src/imgs
	cd part2.7 && docker-compose up

.PHONY: part2.8
part2.8:
	cd part2.6 && docker-compose down
	cd part2.8 && docker-compose down
	if [ ! -z "`docker volume ls -q | grep part26_database`" ] ; then docker volume rm part26_database ; fi
	cd part2.8 && docker-compose up -d
	sleep 10
	test "pong" = "`curl -s 'http://localhost/api/ping'`" && echo SUCCESS

# Cleanup and deps for this task:
# make clean
# make -C ../../part1 part1.12 part1.13 part1.14
.PHONY: part2.9
part2.9:
	cd part2.9 && docker-compose up -d
	sleep 10
	sudo ls -l part2.9/database

.PHONY: part2.10
part2.10:
	diff -u ../part1/part1.12/Dockerfile part2.10/Dockerfile || /bin/true
	diff -u part2.8/docker-compose.yml part2.10/docker-compose.yml || /bin/true
	install part2.10/Dockerfile ../part1/material-applications/example-frontend
	cd ../part1/material-applications/example-frontend && docker build . -t example-frontend
	cd part2.10 && docker-compose up -d

.PHONY: part2.11
part2.11:
	install -m 755 -d part2.11/work
	cd part2.11 && docker-compose up -d 2>&1
	sleep 10
	docker logs boffinlab 2>&1 | tail -n 5

.PHONY: test
test:
	for i in `seq 1 11` ; do f=part2.$${i}.txt ; test -f $$f || exit 1 ; echo $$f ; done

.PHONY: clean
clean:
	$(MAKE) stop-containers prune-containers clean-images clean-volumes
	rm -fr material-applications
	test -z "`docker image ls -q`"
	test -z "`docker container ls -q`"
