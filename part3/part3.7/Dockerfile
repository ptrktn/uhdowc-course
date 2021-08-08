FROM alpine:latest

WORKDIR /usr/src/app

COPY erhelper.sh .

RUN adduser --disabled-password appuser && \
    apk add --no-cache curl python2 && \
    curl -s -L -O https://raw.githubusercontent.com/ptrktn/bz/main/erhelper/erhelper.py && chown appuser /usr/src/app


USER appuser

ENTRYPOINT ["./erhelper.sh"]
