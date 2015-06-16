FROM josephyi/elixir:latest

MAINTAINER Joseph Yi <joe@josephyi.com>

RUN wget -qO- https://deb.nodesource.com/setup | sudo bash -
RUN apt-get update
RUN apt-get install git \
                    nodejs \
                    build-essential \
                    -y


WORKDIR /
RUN mix archive.install --force https://github.com/phoenixframework/phoenix/releases/download/v0.13.1/phoenix_new-0.13.1.ez

EXPOSE 4000

VOLUME ["/app"]
WORKDIR /app
