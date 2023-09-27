FROM ruby:2.7.4

# 必要なライブラリのインストール
RUN apt-get update -qq && apt-get install -y nodejs libpq-dev

#yarn を入れる
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update  && apt-get install -y yarn 
# アプリケーションのディレクトリを作成
WORKDIR /myapp

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install

# アプリケーションのソースをコピー
COPY . .
