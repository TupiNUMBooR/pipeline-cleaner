FROM alpine:3.22

WORKDIR /app/workspace

COPY cleanup.sh /app/cleanup.sh
RUN chmod +x /app/cleanup.sh

CMD ["/app/cleanup.sh"]
