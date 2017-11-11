# Base ubuntu 16-04 image

FROM ubuntu:16.04

RUN apt-get update

RUN dpkg-divert --local --rename --add /sbin/initctl

RUN ln -sf /bin/true /sbin/initctl

RUN apt-get install -y apt-utils \
                       language-pack-en-base \
&& locale-gen en_US.UTF-8

ENV EXPORT LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get install -y \
                    software-properties-common \
                    python-software-properties \
                    zip \
                    nano \
                    git \
                    bash-completion \
                    curl \
                    wget \
                    sudo \
&& rm -rf /var/lib/apt/lists/*

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT exec /bin/bash
