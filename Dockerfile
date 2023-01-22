FROM ruby:2.7.7

RUN apt -y update --fix-missing && \
    apt -y install make gcc && \
    apt clean && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN gem update --system && \
    gem install sass-embedded -v 1.57.1 && \
    gem install github-pages jekyll bundler

COPY Gemfile .
RUN bundle install

EXPOSE 4000

ARG SRC_DIR
WORKDIR ${SRC_DIR}
