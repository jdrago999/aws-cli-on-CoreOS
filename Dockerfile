
FROM alpine:latest

RUN apk add --update \
    python \
    groff \
    py2-pip && \
    adduser -D aws

#ENV PAGER='busybox less' aws cli doesn't work properly with busybox less (bold titles look garbage), but at least it doesn't crash..
#ENV PAGER='more' #is pretty annoying..
ENV PAGER='cat' #So maybe just use cat as default..

WORKDIR /home/aws

RUN mkdir aws && \
    pip install --upgrade pip && \
    pip install awscli

USER aws
