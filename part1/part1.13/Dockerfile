FROM ubuntu:latest

EXPOSE 8080
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=$PATH:/usr/local/go/bin

WORKDIR /usr/src/app
COPY . .

RUN apt-get update -qq
RUN (apt-get -y install curl) > /dev/null 2>&1
RUN curl -sL https://dl.google.com/go/go1.16.6.linux-amd64.tar.gz | gzip -dc | ( cd /usr/local && tar xf - )
RUN go build

CMD ["./server"]


