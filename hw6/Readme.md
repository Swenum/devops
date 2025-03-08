### HW6

1. Через volume подкинуть конфиг в nginx контейнер, чтобы на страничке в браузере появилась слово Docker (либо через curl это проверить).


2. То же самое сделать через docker-compose.
```docker-compose
version: '2'

services:
  nginx:
    restart: always
    image: nginx:latest
    #image: dasskelett/nginx-quic

    hostname: man.swn.by man1.swn.by 
    ports:
      - "80:80/tcp"
      - "443:443/tcp"
      - "443:443/udp"
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - ./letsencrypt:/etc/letsencrypt
      - ./config:/etc/nginx
      - ./www:/var/www/html 
      - ./files:/files
    environment:
      - LE_RENEW_HOOK=docker kill -s HUP @CONTAINER_NAME@
  certbot:
    image: certbot/certbot:latest
    volumes:
      - ./letsencrypt:/etc/letsencrypt
      - .letsencrypt_log:/var/log/letsencrypt/
    command: ["renew"]
```

