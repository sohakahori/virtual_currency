FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir -p /var/www/virtual_currency
WORKDIR /var/www/virtual_currency
ADD Gemfile /var/www/virtual_currency/Gemfile
ADD Gemfile.lock /var/www/virtual_currency/Gemfile.lock
RUN bundle install
ADD . /var/www/virtual_currency
RUN mkdir -p /var/www/virtual_currency/tmp/sockets/
#RUN chmod -R 777 /var/www/virtual_currency/tmp/sockets/


