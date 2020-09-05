FROM rust:1.45-alpine as builder

WORKDIR /build
COPY Cargo.toml .

WORKDIR /build/src
COPY src/main.rs .

WORKDIR /build
RUN cargo install --path /build

FROM alpine:3.12

WORKDIR /app
COPY --from=builder /build/target/release/p3rust .
COPY src/nouns.txt .

CMD ./p3rust