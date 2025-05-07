FROM golang:1.18-alpine

RUN mkdir /app

RUN addgroup -S basgroup
RUN adduser -S -D -h /app basuser basgroup
RUN chown -R basuser:basgroup /app

USER basuser

COPY main.go /app

EXPOSE 8080

CMD ["go", "run", "/app/main.go"]
