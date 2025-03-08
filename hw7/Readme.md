### HW7

1. Развернуть Jenkins.
```docker-compose
services:
  jenkins:
    restart: always
    image: jenkins/jenkins:lts-jdk17
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - ./jenkins_home:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
    user: root
    networks:
      - cicd_network

  nexus:
    restart: always
    image: sonatype/nexus3
    ports:
      - "8081:8081"
      - "8083:8083"
    volumes:
      - nexus_data:/nexus-data
    networks:
      - cicd_network
volumes:
  nexus_data:
    external: true
    name: nexus_data


networks:
    cicd_network:
        driver: bridge


```
2. Подключить Linux Slave к Jenkins.

3. Создать Jenkins pipeline, pipeline должен уметь разворачивать ELK stack. Если не хватает ресурсов, тогда развернуть только Elasticsearch.
   ELK стек должен разворачиваться на новом слейве.
