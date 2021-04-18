FROM ruby:3
RUN curl -fsSL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get update -qq && apt-get install -y --no-install-recommends nodejs postgresql-client

WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY vendor/cache /myapp/vendor/cache

RUN gem install bundler -v 2.2.15 && bundle _2.2.15_ config set --local path 'vendor/cache' && bundle _2.2.15_ install

COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock
COPY vendor/yarn /myapp/vendor/yarn

RUN npm install npm@latest -g && \
npm install --global yarn && \
yarn install --cache-folder 'vendor/yarn' && \
yarn add --dev --cache-folder 'vendor/yarn' \
jquery@3.5.1 webpack-cli @rails/ujs turbolinks bootstrap@3.4.1 @popperjs/core \
css-loader mini-css-extract-plugin css-minimizer-webpack-plugin \
sass sass-loader postcss-loader postcss

COPY . /myapp

RUN bundle
RUN bundle exec rails webpacker:install
RUN yarn

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]