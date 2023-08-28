FROM ruby:3.0

WORKDIR /app
COPY . /app/

RUN bundle install

ENTRYPOINT [ "ruby", "/app/bin/run.rb" ]
