FROM golang:latest AS builder


COPY app.go .

RUN go get -d -v github.com/lib/pq github.com/julienschmidt/httprouter
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

COPY --from=builder /go/app .
COPY blockchain.html /

EXPOSE 8000

CMD ["./app"]