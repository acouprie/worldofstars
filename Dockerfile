FROM ruby:2.3.3

# Define local mirror (if this one fail, just change http://ftp2.fr to http://ftp2.de)
RUN echo "deb http://security.debian.org/ jessie/updates main contrib non-free" > /etc/apt/sources.list
RUN echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://ftp2.de.debian.org/debian/ jessie main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp2.de.debian.org/debian/ jessie main contrib non-free" >> /etc/apt/sources.list

RUN apt-get clean && apt-get update -y \
      && apt-get install -y --no-install-recommends git-core build-essential sudo libffi-dev libxml2-dev libssl-dev \
      && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash ether
RUN echo '%ether ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /app
RUN mkdir -p /bundle

WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/
COPY vendor/gems/ /app/vendor/gems/

RUN chown -hR ether:ether /app
RUN chown -hR ether:ether /bundle

USER ether

ENV BUNDLE_JOBS=10 \
    BUNDLE_PATH=/bundle \
    BUNDLE_APP_CONFIG=/app/.bundle-docker/

RUN bundle config #frozen 1
RUN bundle install --clean

COPY . /app/

# unicorn
EXPOSE 3000
ENV PORT 3000


