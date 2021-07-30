FROM ubuntu:18.04
WORKDIR /usr/src/app
RUN apt-get update -qq
RUN (apt-get -y install curl) > /dev/null 2>&1
COPY curler.sh .
CMD ./curler.sh

