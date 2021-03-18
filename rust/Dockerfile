FROM rust:1.50-alpine as builder

WORKDIR /build
COPY . .

RUN cargo build --release

FROM scratch

COPY --from=builder /build/target/release/p3rust /
COPY src/nouns.txt /

CMD [ "/p3rust" ]