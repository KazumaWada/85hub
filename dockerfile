# ベースイメージとして公式のRubyイメージを使用
FROM ruby:3.2

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y nodejs postgresql-client

# 作業ディレクトリを指定
WORKDIR /app

# GemfileとGemfile.lockをコピー（初回はGemfile.lockがないかもしれません）
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# 必要なGemをインストール
RUN bundle install

# アプリケーションコードをコピー
COPY . /app

# ポート3000を公開
EXPOSE 3000
