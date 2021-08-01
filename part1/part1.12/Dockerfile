FROM ubuntu:latest

EXPOSE 5000

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /usr/src/app
COPY . .

RUN apt-get update -qq
RUN (apt-get -y install nodejs npm) > /dev/null 2>&1
RUN npm install
RUN npm run build
RUN npm install -g serve

CMD ["serve", "-s", "-l", "5000", "build"]

