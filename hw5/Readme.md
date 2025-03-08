### HW5

1. Зарегистрироваться в Dockerhub.
2. Создать свой любой имадж(использовать Dockerfile) и запушить имадж в свой репозиторий в Dockerhub. Репозиторий сделать приватный.
```Dockerfile
# Stubby - Sends all outgoing DNS queries received on those addresses out over TLS

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
    groupadd getdns 
RUN  set -x && \
    cd /tmp/src/getdns/getdns-1.7.3 && \
    cmake -DENABLE_STUB_ONLY=ON  -DBUILD_TESTING=OFF . && \
    make && \
    rm -rf /tmp/* && \
    mkdir -p /opt/getdns/var/run/ && \
    chmod 777 /opt/getdns/var/run/
   


CMD ["/bin/bash", "-c", "read varname"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
```

```bash
# Cобираем образ, файлы берём из текущей директории
docker build .
docker login
```

3. Изучить разницу между CMD и Entrypoint.

```
В Dockerfile две важные инструкции, которые определяют, какой исполняемый файл будет запущен при старте контейнера, это `CMD` и `ENTRYPOINT`. Хотя обе инструкции выглядят похожими, между ними есть ключевые отличия в поведении и назначении.

Инструкция `CMD`

Задает команду и её аргументы по умолчанию, которые будут выполнены при запуске контейнера. Однако, если при запуске контейнера указаны любые другие команды, они заменят команду, заданную через него. Это делает его идеальным выбором для задания параметров по умолчанию, которые могут быть переопределены пользователем при запуске контейнера.

Пример:
```
```dockerfile
FROM ubuntu
CMD ["echo", "Hello, world!"]
```
```
При запуске этого контейнера без дополнительных параметров, будет выведено "Hello, world!". Но если при запуске указать другую команду, например `docker run <image> echo "Hello, Docker!"`, то будет выведено "Hello, Docker!".

Инструкция `ENTRYPOINT`

Конфигурирует контейнер так, что он будет запущен как исполняемый файл. Аргументы, указанные при запуске контейнера, передаются в него как дополнительные аргументы. Это означает, что команда, заданная в него, не заменяется, а дополняется аргументами, указанными при запуске контейнера.

Пример:
```
```dockerfile
FROM ubuntu
ENTRYPOINT ["echo", "Hello,"]
CMD ["world!"]
```
```
Здесь, если контейнер запущен без дополнительных аргументов, вывод будет "Hello, world!". Если же запустить контейнер с дополнительными аргументами, например `docker run <image> Docker`, то вывод будет "Hello, Docker".

Основные отличия

1. Переопределение команды: `CMD` может быть полностью переопределена при запуске контейнера, в то время как `ENTRYPOINT` предопределяет базовую команду, и любые аргументы, указанные при запуске, добавляются к этой команде.
2. Использование в комбинации: Часто `ENTRYPOINT` используется в комбинации с `CMD`, где `ENTRYPOINT` задает исполняемый файл, а `CMD` задает аргументы по умолчанию, которые могут быть переопределены при запуске.

`CMD` и `ENTRYPOINT` обе определяют, какая команда будет выполнена при запуске Docker-контейнера, но делают это по-разному. `CMD` лучше использовать для задания параметров по умолчанию, которые могут быть изменены, а `ENTRYPOINT` для установки фиксированной базовой команды, к которой можно добавлять аргументы.
```
