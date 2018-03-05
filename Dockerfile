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

RUN \

  curl -sL https://deb.nodesource.com/setup_8.x | bash - && \

  apt-get install -y nodejs && \

  npm install -g expressjsmvc express nodemon bower grunt-cli ionic@latest cordova@latest

RUN \

  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \

  sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \

  sudo apt-get update \

  sudo apt-get install google-chrome-stable \

  echo "bamboo ALL = NOPASSWD: /usr/bin/google-chrome" >> /etc/sudoers.d/bamboo


ENV CHROME_BIN /usr/bin/google-chrome

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT exec /bin/bash
