FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /virtual_currency
WORKDIR /virtual_currency
ADD Gemfile /virtual_currency/Gemfile
ADD Gemfile.lock /virtual_currency/Gemfile.lock
RUN bundle install
ADD . /virtual_currency
