FROM golang:1.22 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /tracker

FROM alpine
WORKDIR /app
COPY --from=builder /tracker ./
COPY tracker.db ./
CMD [ "./tracker" ]