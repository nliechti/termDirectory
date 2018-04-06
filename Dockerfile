FROM elixir:1.6

MAINTAINER Niklas Liechti <nliechti@protonmail.ch>

ENV MIX_ENV=prod
ENV PORT=4000

RUN mix local.hex --force && \
	mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez && \
	mix local.rebar --force

COPY . /app

WORKDIR /app

# install node
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs

RUN mix deps.get --only prod && \
	MIX_ENV=prod mix compile && \
	mix compile && \
	mix phx.digest
	
# install node dependencies
RUN npm install

# build only the things for production
RUN node node_modules/brunch/bin/brunch build --production

RUN mix ecto.create && \
	mix	ecto.migrate

CMD "mix phx.server"
