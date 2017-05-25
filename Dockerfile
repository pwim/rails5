FROM heroku/cedar

RUN cd /tmp && git clone https://github.com/heroku/heroku-buildpack-ruby
ENV HOME=/app
WORKDIR /app

ENV CURL_CONNECT_TIMEOUT=0 \
  CURL_TIMEOUT=0 \
  GEM_PATH="$HOME/vendor/bundle/ruby/2.3.0:$GEM_PATH" \
  LANG=${LANG:-en_US.UTF-8} \
  PATH="$HOME/bin:$HOME/vendor/bundle/bin:$HOME/vendor/bundle/ruby/2.3.0/bin:$PATH" \
  RACK_ENV=${RACK_ENV:-production} \
  RAILS_ENV=${RAILS_ENV:-production} \
  RAILS_LOG_TO_STDOUT=${RAILS_LOG_TO_STDOUT:-enabled} \
  RAILS_SERVE_STATIC_FILES=${RAILS_SERVE_STATIC_FILES:-enabled} \
  SECRET_KEY_BASE=${SECRET_KEY_BASE:-e0f481a3160bdb78689fb3195da18ec0db950463e14c2f8c4b31d4beea755cd70908e4ceb71987ae89d75868a1ceba0d6b3ae71c7863f32307132a489e7da293} \
  STACK=cedar-14

ARG BUNDLE_WITHOUT=development:test

# This is to install sqlite for any ruby apps that need it
# This line can be removed if your app doesn't use sqlite3
RUN apt-get update && apt-get install sqlite3 libsqlite3-dev && apt-get clean

COPY . /app

RUN output=$(/tmp/heroku-buildpack-ruby/bin/compile /app /tmp/cache) || echo $output
