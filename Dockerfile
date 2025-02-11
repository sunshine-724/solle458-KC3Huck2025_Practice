# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM node:22.12.0-bullseye-slim as builder

# 必要なパッケージインストール
RUN apt-get update \
    && apt-get install -y curl git build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# pyenvのインストール
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN curl https://pyenv.run | bash \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc \
    && echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc \
    && echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

# 作業ディレクトリの作成
WORKDIR /app/react-app

# Node.js の依存パッケージインストール
COPY ./react-app ./
RUN npm install && npm install web-vitals

# Pythonのインストールと仮想環境作成
ENV PATH="/root/.pyenv/shims:$PATH"
RUN pyenv install 3.9.20 \
    && pyenv global 3.9.20 \
    && python -m venv venv

# 環境変数設定
ENV PATH="/app/venv/bin:$PATH"

# Python依存ライブラリのインストール
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

CMD ["npm", "start"]
