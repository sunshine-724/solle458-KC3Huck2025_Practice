# syntax=docker/dockerfile:1.4

# Python 3.9.18 ベースイメージ
FROM --platform=$BUILDPLATFORM python:3.9.18-slim-bullseye

# 必要なパッケージをインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成
WORKDIR /app/backend

# アプリケーションのソースコードをコピー（仮想環境の作成前に実行）
COPY . .

# Python仮想環境の作成
RUN python -m venv .venv && \
    pip install -r requirements.txt

# 環境変数設定（.venv を優先的に使う）
ENV PATH="/app/backend/.venv/bin:$PATH"

# Flask の環境変数を設定
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development

# Flaskアプリを起動（.venvを明示的に有効化）
CMD [ "python", "app.py" ]
