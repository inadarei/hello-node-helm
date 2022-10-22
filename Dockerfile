FROM python:3.10-alpine
LABEL maintainer="Irakli Nadareishvili"

ARG BUILD_DATE
LABEL org.label-schema.build-date=$BUILD_DATE

COPY . /app
WORKDIR /app

RUN apk upgrade --update \
 && apk add --no-cache build-base \
 && apk add bash \
 && pip install -r requirements.txt \
 && apk del build-base # reduce size \
 && echo never > /sys/kernel/mm/transparent_hugepage/enabled \
 && apk add make


CMD ["gunicorn", "-b 0.0.0.0:7701", "--reload", \
     "-w 4", "service:app"]
