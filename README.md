# TIN/ITN (ИНН) checker

Validate TIN/ITN and do other work a bit.

## Requirements

- For development: bash, asdf-vm with erlang/elixir/nodejs plugins, docker, docker compose. Code editor which you like. Linux recommended.
- For build release: bash, docker. Linux recommended.
- For production: bash, postgresql, docker, docker compose. Linux recommended. Reverse proxy is on your own.

## Development

- Run `asdf install` for install erlang, elixir, nodejs.
- Run `make build` for fetch and compile dependencies.
- Run `dev/up` for start developer's Postgres. Tune port in `dev/.vars` if need.
- Run `mix ecto.migrate` for apply migrations.
- Run `mix run priv/repo/seeds.exs` for create 'admin' and 'operator' users.
- Run `mix phx.server` and open `http://localhost:4000` in your browser.
- See logs in console.

- Run `make test` for tests.

## Build release and deploy to production

- Prepare remote host with ssh access by rsa key without password.
- Prepare domain name. Ssl cert is up to you.
- Choose some port, 4000 for example, and set up reverse proxy from 80/443 on it.
- Set up postgres, database should exists.
- Create target file based on `deploy/sample-target.env`.
- Run `deploy/bin/build`.
- Run `deploy/bin/deploy -t your-target-file.env`. Migrations will be applied automatically.
- Open your site in browser.
- Run `deploy/bin/clean` for clean up local artifacts.

## Notes

No Redis engaged. No automatic unban after specified time. Banned ips keeps just in Agent and drops with application restart/redeploy.

## License

MIT
