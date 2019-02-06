# Boilerplate API

Golang Boilerplate API

## Installation
```
$ go get github.com/benkauffman/go-boilerplate-api
```

## Build binary
```
make build
```

## How to run
run using docker compose with all of the required services
```
make up
```
stop with docker compose
```
make down
```

### Required
- Docker
- Mysql
- Redis

### Conf

Not necessary for development, but you should modify `conf/app.ini` for production releases

```
[server]
RunMode = debug
HttpPort = 5000
ReadTimeout = 60
WriteTimeout = 60

[database]
Type = mysql
User = Boilerplate
Password = 12345678
Host = mysql:3306
Name = Boilerplate
TablePrefix = Boilerplate_
Version = 1

[redis]
Host = 127.0.0.1:6379
Password =
MaxIdle = 30
MaxActive = 30
IdleTimeout = 200
...
```

### Running without docker (development only)
```
$ cd $GOPATH/src/go-boilerplate-api

$ go run main.go 
```

## Features

- RESTful API
- Gorm
- Swagger
- logging
- Jwt-go
- Gin
- Graceful restart or stop (fvbock/endless)
- App configurable
- Cron
- Redis