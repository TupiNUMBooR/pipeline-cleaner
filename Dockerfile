FROM alpine:3.22

WORKDIR /clean

COPY cleaner.sh /cleaner.sh
RUN chmod +x /cleaner.sh

CMD ["/cleaner.sh"]
