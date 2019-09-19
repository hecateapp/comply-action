# FROM strongdm/comply:latest
FROM golang:latest

RUN go get github.com/strongdm/comply

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]