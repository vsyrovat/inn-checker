FROM hexpm/elixir:1.13.3-erlang-24.2.2-debian-bullseye-20210902 AS build

RUN apt-get install -y build-essential npm && \
    mix local.hex --force && \
    mix local.rebar --force

WORKDIR /app

# ENV LC_ALL=en_US.utf8
# RUN ulimit -n 16384

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
RUN mix do deps.get --only prod, deps.compile

COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY assets assets
RUN npm run --prefix ./assets deploy

COPY config config
COPY priv priv
RUN mix phx.digest

COPY lib lib
RUN mix do compile, release


FROM debian:bullseye-20210902-slim AS app

WORKDIR /app

RUN chown nobody:nogroup /app

USER nobody:nogroup

COPY --from=build --chown=nobody:nogroup /app/_build/prod/rel/app ./

ENV HOME=/app

CMD ["bin/app", "start"]
