FROM alpine:latest
MAINTAINER liuyang

RUN set -ex && \
	sed -i '/dl-cdn.alpinelinux.org/s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
	apk upgrade --update && \
	apk add --update bash python py-pip py2-lxml py2-psycopg2 && \
	pip install gunicorn chardet flask lxml jieba psycopg2  requests && \
	mkdir -p /var/log/python && \
	rm -rf /var/cache/apk/*

WORKDIR /opt/online/service_catalog_web
EXPOSE 7777
CMD gunicorn -w 5 -b 0.0.0.0:7777 start_cut_mod:app
