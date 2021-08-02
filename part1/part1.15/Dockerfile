FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/src/app

COPY . .

RUN apt-get update -qq
RUN (apt-get -y install curl python2) > /dev/null 2>&1
RUN curl -s -L -O https://raw.githubusercontent.com/ptrktn/bz/main/erhelper/erhelper.py

ENTRYPOINT ["./erhelper.sh"]


