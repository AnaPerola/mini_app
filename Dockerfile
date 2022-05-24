FROM ruby:2.7.1

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn \
  && apt-get clean

WORKDIR /www/miniapp

COPY Gemfile /www/miniapp/Gemfile
COPY Gemfile.lock /www/miniapp/Gemfile.lock
RUN bundle install

COPY package.json /www/miniapp/package.json 
COPY yarn.lock /www/miniapp/yarn.lock
RUN yarn install
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]