FROM alpine:latest

WORKDIR /app

RUN apk add --no-cache bash
COPY feishu_chatgpt /app
COPY role_list.yaml /app
EXPOSE 9000
ENTRYPOINT ["/app/feishu_chatgpt"]
