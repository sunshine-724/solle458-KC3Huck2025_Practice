FROM --platform=$BUILDPLATFORM node:22.12.0-bullseye-slim as builder

# 必要なパッケージインストール
RUN apt-get update \
    && apt-get install -y curl git build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの作成
WORKDIR /app
COPY . .

# pyenvのインストール
ENV PYENV_ROOT="/root/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
RUN curl https://pyenv.run | bash \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc \
    && echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc \
    && echo 'eval "$(pyenv init --path)"' >> ~/.bashrc

# Pythonのインストールと仮想環境作成
ENV PATH="/root/.pyenv/shims:$PATH"
RUN pyenv install 3.9.18 \
    && pyenv global 3.9.18 \
    && python -m venv venv \
    && pip install --upgrade pip

# backendのsetup
RUN cd backend && pip install -r requirements.txt

# frontendのsetup
RUN cd frontend && npm install && npm install web-vitals axios

# コンテナ起動時に実行するコマンド
# CMD ["cd backend && flask run --host=0.0.0.0 --port=5001", "cd frontend && npm start"] #意味なし
