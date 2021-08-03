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

.PHONY: test
test:
	for i in `seq 1 16` ; do f=part2.$${i}.txt ; test -f $$f || exit 1 ; echo $$f ; done

.PHONY: clean
clean:
	$(MAKE) stop-containers prune-containers clean-images
	rm -fr material-applications
	test -z "`docker image ls -q`"
	test -z "`docker container ls -q`"
