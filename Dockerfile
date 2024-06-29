FROM ruby:3.3.3

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends \
       apt-transport-https \
       bash \
       bash-completion \
       ca-certificates \
       curl \
       g++ \
       git \
       gnupg2 \
       imagemagick \
       libcurl4 \
       libcurl4-openssl-dev \
       libffi-dev \
       libssl-dev \
       make \
       nodejs \
       npm \
       postgresql-client \
       ssh \
       tzdata \
       wget \
       yarn \
       zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV MAKE="make --jobs 8"

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD rails s
