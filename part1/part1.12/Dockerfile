FROM ubuntu:latest

EXPOSE 5000

ENV DEBIAN_FRONTEND=noninteractive
# 1.14
ENV REACT_APP_BACKEND_URL=http://localhost:8080
WORKDIR /usr/src/app
COPY . .

RUN apt-get update -qq
RUN (apt-get -y install nodejs npm) > /dev/null 2>&1
RUN npm install
RUN npm run build
RUN npm install -g serve

CMD ["serve", "-s", "-l", "5000", "build"]

