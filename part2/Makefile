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
	if [ ! -z "$$XID" ] ; then docker image rm $$XID || exit 1 ; fi

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

.PHONY: test
test:
	for i in `seq 1 16` ; do f=part2.$${i}.txt ; test -f $$f || exit 1 ; echo $$f ; done

.PHONY: clean
clean:
	$(MAKE) stop-containers prune-containers clean-images
	rm -fr material-applications
	test -z "`docker image ls -q`"
	test -z "`docker container ls -q`"
