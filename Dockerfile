FROM ruby:2.7.1

RUN apt-get update -qq \
    && apt-get install -y curl build-essential apt-transport-https libpq-dev locales wget \
    && apt-get clean

WORKDIR /www/miniapp

COPY Gemfile /www/miniapp/Gemfile
COPY Gemfile.lock /www/miniapp/Gemfile.lock
RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]