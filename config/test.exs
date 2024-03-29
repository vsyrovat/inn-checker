import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :app, App.Repo,
  username: "postgres",
  password: "postgres",
  database: "app_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  port: String.to_integer(System.get_env("PG_PORT") || "5432"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :app, AppWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :app, App.Guardian, secret_key: "TestSecretKey"
config :argon2_elixir, t_cost: 1, m_cost: 8
