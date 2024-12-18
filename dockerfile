# ベースイメージとして公式のRubyイメージを使用
FROM ruby:3.2.6

# 必要なパッケージとTesseract OCRをインストール
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        postgresql-client \
        cron \
        tesseract-ocr \
        libtesseract-dev \
        imagemagick && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Bundler と Whenever をインストール
RUN gem install bundler --no-document
RUN gem install whenever --no-document

# 作業ディレクトリを指定
WORKDIR /app

# 依存関係のインストールを効率化するため、GemfileとGemfile.lockを先にコピー
COPY Gemfile Gemfile.lock ./

# プラットフォームを指定してBundlerをインストール
RUN bundle lock --add-platform x86_64-linux && \
    bundle install --jobs=4 --retry=3

# アプリケーションコードをコピー
COPY . .

# wheneverでcronタスクを生成（config/schedule.rbが存在する前提）
RUN if [ -f config/schedule.rb ]; then whenever --update-crontab; fi

# ポート3000を公開
EXPOSE 3000

# アプリケーションの起動とcronサービスの開始
CMD ["sh", "-c", "service cron start && bin/rails db:migrate RAILS_ENV=production && rails server -b 0.0.0.0"]
