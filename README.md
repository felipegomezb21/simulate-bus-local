# BUS local

Este es un proyecto para simular los componentes basicos del BUS de integración en local con docker.

# Componentes y Servicios

* `kafka`: Broker de mensajeria.
  - Puerto: `9092`
* `zookeeper`: 
  - Puerto: `2181`
* `kafka-ui`: 
  - Puerto: `8080`
* `apicurio`: 
  - Puerto: `8082`
* `Kafka Connect`: 
  - Puerto: `8083`
* `PostgreSQL`: 
  - Puerto: `5432`
  - USER: myuser
  - PASSWORD: mypassword
  - POSTGRES_DB: mydatabase

# Requisitos para ejecutar

* Docker

# ¿Como ejecutar?

1. Ejecutar Proyecto:

Desde la raiz del proyecto, ejecutar la siguiente instrucción:

```
$ docker-compose up -d

```
Esto desplegara todo lo necesario: `kafka`, `kafka-ui`, `kafka-connect`, `apicurio`, `postgresql` y las aplicaciones parametrizadas. Adicionalmente creara recursos base de ejemplo como:

* Connectors in kafka connect
* Schemas in apicurio
* Topics in kafka
* tables in postgresql

# Conclusiones
