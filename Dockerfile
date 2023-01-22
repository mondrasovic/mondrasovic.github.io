FROM jekyll/jekyll:4.0

RUN gem install jekyll bundler

COPY Gemfile .

RUN bundle install

ARG SRC_DIR
WORKDIR ${SRC_DIR}