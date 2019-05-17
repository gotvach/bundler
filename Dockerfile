FROM ubuntu:14.04

LABEL description="ruby/bundler rspec testing for puppet 3.x"
LABEL maintainer="grant@f1fox.net"

ENV PUPPETDEB puppetlabs-release-trusty.deb
ENV MODULES_DIR modules
ENV MODULE .

RUN apt-get -q update && \
    apt-get -y upgrade && \
    apt-get -q -y install curl && \
    apt-get clean && \
    rm -rf /var/apt/cache/*

RUN curl -O https://apt.puppetlabs.com/$PUPPETDEB && \
    dpkg -i $PUPPETDEB && rm $PUPPETDEB

RUN apt-get -q update && \
    apt-get -q -y install \
        git \
        puppet \
        puppet-common \
        ruby1.9.1 \
        ruby1.9.1-dev \
        make \
        zlib1g-dev \
        g++

RUN gem install bundler -v 1.17.3

COPY bundle.sh /usr/local/bin/bundle.sh

ENTRYPOINT ["bundle.sh"]
