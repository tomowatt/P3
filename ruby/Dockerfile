FROM ruby:2.7.1-alpine

RUN gem install bundler

WORKDIR /app
COPY Gemfile .
RUN bundle install

WORKDIR /app/src
COPY src .

CMD ruby app.rb