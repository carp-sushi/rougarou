import Config

# Print warnings and errors running tests
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :logger, level: :warning

config :rougarou, Rougarou.Repo,
  username: "postgres",
  password: "password1",
  hostname: "localhost",
  database: "rougarou_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2
