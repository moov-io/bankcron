FROM golang:1.19-alpine as builder
WORKDIR /go/src/github.com/moov-io/bankcron
RUN apk add -U git make
RUN adduser -D -g '' --shell /bin/false moov
COPY . .
RUN make build
USER moov

FROM alpine:3.17
LABEL maintainer="Moov <oss@moov.io>"

RUN apk add -U curl tzdata

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/src/github.com/moov-io/bankcron/bin/bankcron /bin/bankcron
COPY --from=builder /usr/local/go/lib/time/zoneinfo.zip /zoneinfo.zip
COPY --from=builder /etc/passwd /etc/passwd

USER moov
EXPOSE 8080
EXPOSE 9090
ENTRYPOINT ["/bin/bankcron"]
