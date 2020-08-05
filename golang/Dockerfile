FROM golang:1.14-alpine

WORKDIR /app/src
COPY src .

RUN go build app.go
CMD ./app