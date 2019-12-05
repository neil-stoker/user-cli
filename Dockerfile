FROM golang:alpine as builder

RUN apk --no-cache add git

WORKDIR /app/user-cli

COPY . .

RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix=cgo -o user-cli

FROM alpine:latest

RUN apk --no-cache add ca-certificates

RUN mkdir /app

COPY --from=builder app/user-cli .

RUN dir

CMD ["./user-cli"]

