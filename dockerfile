# ベースイメージとして公式のRubyイメージを使用
FROM ruby:3.2.6

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev postgresql-client cron && \
    apt-get clean && rm -rf /var/lib/apt/lists/*



# Bundler をインストール
RUN gem install bundler --no-document
RUN gem install whenever --no-document

# 作業ディレクトリを指定
WORKDIR /app

# 依存関係のインストールを効率化するため、GemfileとGemfile.lockを先にコピー
COPY Gemfile Gemfile.lock ./

# プラットフォームを指定してBundlerをインストール
RUN bundle lock --add-platform x86_64-linux && \
    bundle install --jobs=4 --retry=3

#schedule.rbが存在する場合
RUN whenever --update-crontab || echo "wheneverコマンドが失敗しました"


# アプリケーションコードをコピー
COPY . .

# キャッシュを活用しやすくするため、最後にコードを追加
# これにより、Gemfileが変更されない限り、`bundle install` のキャッシュが再利用されます。

# ポート3000を公開
EXPOSE 3000

# CMDはdockerfile内で一度だけ実行できる。だから、本番と開発どちらも書く。
#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["sh", "-c", "service cron start" && "bin/rails db:migrate RAILS_ENV=production && rails server -b 0.0.0.0"]


