FROM ubuntu:14.04

LABEL description="ruby/bundler rspec testing for puppet 3.x"
LABEL maintainer="Grant Hammond <grant@f1fox.net>"

ARG DEBIAN_FRONTEND=noninteractive

ENV PUPPETDEB puppetlabs-release-trusty.deb
ENV MODULES_DIR modules
ENV MODULE .

RUN    apt-get -q update \
    && apt-get -q -y upgrade \
    && apt-get -q -y install curl \
    && apt-get -q -y install --no-install-recommends \
        git \
        ruby1.9.1 \
        ruby1.9.1-dev \
        make \
        zlib1g-dev \
        g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/docs \
    && rm -rf -- ~/.gem

# RUN curl -O https://apt.puppetlabs.com/$PUPPETDEB && \
#     dpkg -i $PUPPETDEB && rm $PUPPETDEB
        # puppet \
        # puppet-common \

RUN gem install bundler -v 1.17.3

COPY bundle.sh /usr/local/bin/bundle.sh

ENTRYPOINT ["bundle.sh"]
