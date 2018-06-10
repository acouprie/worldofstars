FROM ruby:2.3.3

# Define local mirror (if this one fail, just change http://ftp2.fr to http://ftp2.de)
RUN echo "deb http://security.debian.org/ jessie/updates main contrib non-free" > /etc/apt/sources.list
RUN echo "deb-src http://security.debian.org/ jessie/updates main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb http://ftp2.de.debian.org/debian/ jessie main contrib non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://ftp2.de.debian.org/debian/ jessie main contrib non-free" >> /etc/apt/sources.list

RUN apt-get clean && apt-get update -y \
      && apt-get install -y --no-install-recommends git-core build-essential sudo libffi-dev libxml2-dev libssl-dev \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
RUN mkdir -p /bundle

WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN bundle install

COPY . /app/

# unicorn
EXPOSE 3000
ENV PORT 3000
