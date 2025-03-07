FROM ubuntu:jammy
LABEL maintainer="Uladzimir Schuka <wetoster@gmail.com>"
USER root

RUN sed -i -e 's/^APT/# APT/' -e 's/^DPkg/# DPkg/' \
      /etc/apt/apt.conf.d/docker-clean

RUN apt-get update && apt-get install -y \
    bash \
    bind9 \
    wget \
    automake \
    make \
    cmake \
    git \
    gcc \
    check\
    build-essential \
    libunbound-dev \
    libldns-dev \
    autoconf \
    libevent-dev \
    libuv1-dev \
    libev-dev \
    libssl-dev \
    libidn11-dev \
    libidn2-dev \
    libyaml-dev \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN set -x && \
    mkdir -p /tmp/src/getdns && \
    cd /tmp/src/getdns && \
    wget -O getdns.tar.gz https://getdnsapi.net/releases/getdns-1-7-3/getdns-1.7.3.tar.gz && \
    tar xzf getdns.tar.gz && \
    rm -f getdns.tar.gz && \
    cd getdns-1.7.3 && \
    groupadd getdns && \
    cd /tmp/src/getdns/getdns-1.7.3 && \
    cmake -DENABLE_STUB_ONLY=ON  -DBUILD_TESTING=OFF . && \
    make && \
    make install && \
    ldconfig && \
    rm -rf /tmp/* && \
    mkdir -p /opt/getdns/var/run/ && \
    chmod 777 /opt/getdns/var/run/ 
RUN set -x && \
    mkdir -p /tmp/src/stubby && \   
    cd /tmp/src/stubby && \
    git clone https://github.com/getdnsapi/stubby.git && \
    cd stubby  && \
    cmake .  && \
    make  && \
    make install 
COPY stubby.yml /usr/local/etc/stubby/stubby.yml
EXPOSE 8053
EXPOSE 8053/udp
CMD [ "/usr/local/bin/stubby" ]
#ENTRYPOINT ["tail", "-f", "/dev/null"]