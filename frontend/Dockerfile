# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM node:22.12.0-bullseye-slim as builder

# 必要なパッケージインストール
RUN apt-get update \
    && apt-get install -y curl git build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成
WORKDIR /app/frontend

# Node.js の依存パッケージインストール
COPY . .
RUN npm install && npm install web-vitals

CMD ["npm", "start"]
