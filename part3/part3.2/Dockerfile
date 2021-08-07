FROM ubuntu
WORKDIR /usr/src/app
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq
RUN (apt-get -y install git docker docker-compose) > /dev/null 2>&1
COPY github2dockerhub.sh .
ENTRYPOINT ["./github2dockerhub.sh"]
