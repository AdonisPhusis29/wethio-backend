FROM golang:1.10-alpine as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . /zynecoin
RUN cd /zynecoin && make zyn

FROM alpine:latest

LABEL maintainer="etienne@zynecoin.com"

WORKDIR /zynecoin

COPY --from=builder /zynecoin/build/bin/zyn /usr/local/bin/zyn

RUN chmod +x /usr/local/bin/zyn

EXPOSE 8545
EXPOSE 30303

ENTRYPOINT ["/usr/local/bin/zyn"]

CMD ["--help"]
