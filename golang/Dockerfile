FROM golang:1.15-alpine as builder

WORKDIR /build
COPY src/app.go .

RUN go build -o app

FROM alpine:3.12

WORKDIR /app/src

COPY --from=builder /build/app .
COPY src/nouns.txt .

CMD ./app