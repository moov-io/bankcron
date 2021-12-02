FROM golang:1.17-alpine as builder
WORKDIR /go/src/github.com/moov-io/bankcron
RUN apk add -U make
RUN adduser -D -g '' --shell /bin/false moov
COPY . .
RUN make build
USER moov

FROM alpine:20210804
LABEL maintainer="Moov <support@moov.io>"

RUN apk add -U curl

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/src/github.com/moov-io/bankcron/bin/bankcron /bin/bankcron
COPY --from=builder /etc/passwd /etc/passwd

USER moov
EXPOSE 8080
EXPOSE 9090
ENTRYPOINT ["/bin/bankcron"]
