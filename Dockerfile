FROM ruby:3.3.13

WORKDIR /app

ENV MAKE="make --jobs 8"

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
       ssh \
       tzdata \
       wget \
       zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y ca-certificates curl gnupg \
 && mkdir -p /etc/apt/keyrings \
 && curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg \
    | gpg --dearmor -o /etc/apt/keyrings/yarn.gpg \
 && echo "deb [signed-by=/etc/apt/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" \
    > /etc/apt/sources.list.d/yarn.list \
 && apt-get update

RUN apt-get update -qq && apt-get install -y npm nodejs postgresql-client yarn

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD rails s
