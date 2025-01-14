FROM golang:1.21.5 
WORKDIR /app 
COPY go.mod .
COPY main.go .
RUN go mod tidy
RUN go build -o main . 
EXPOSE 8082
CMD ["./main"] 