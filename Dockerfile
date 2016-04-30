
FROM ubuntu:15.10

RUN apt-get update
RUN apt-get install -y \
    python \
    python-pip

RUN adduser --disabled-login --gecos '' aws
WORKDIR /home/aws

RUN \
    mkdir aws && \
    pip install awscli

USER aws
