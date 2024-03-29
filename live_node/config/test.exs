import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :live_node, LiveNode.Repo,
  username: "carl",
  password: "kaggenloaf",
  hostname: "10.10.0.10", # while running on windows, using "localhost" did not seem to allow connecting to the DB
  port: "5433",
  database: "live_node_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_node, LiveNodeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xnfrGsZ4XrTWnuiycw84LNydfk3CdNjizfkkhiL+j3jjlsOFR+/OFuWqrwa6eQT9",
  server: false

# In test we don't send emails.
config :live_node, LiveNode.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
# config :logger, level: :info
# config :logger, level: :warning
config :logger,
  backends: [:console],
  compile_time_purge_matching: [
  [level_lower_than: :debug]
]

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
