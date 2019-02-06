FROM golang:1.11.5

RUN ["mkdir", "-p", "/usr/local/go/src/github.com/benkauffman/go-boilerplate-api"]

WORKDIR /usr/local/go/src/github.com/benkauffman/go-boilerplate-api

# hot reloading
RUN ["go", "get", "github.com/oxequa/realize"]

# start hot reloading
# realize start --path="${PWD}" --run go-boilerplate-api
CMD ["realize", "start"]
