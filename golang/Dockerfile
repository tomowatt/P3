FROM golang:1.15-alpine as builder

WORKDIR /build
COPY src/app.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o app

FROM scratch

COPY --from=builder /build/app /
COPY src/nouns.txt /

CMD [ "/app" ]