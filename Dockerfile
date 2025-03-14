FROM golang:1.21.5

RUN mkdir /app

ADD . /app

WORKDIR /app

RUN go build -o main .

EXPOSE 8181

CMD [ "/app/main" ]