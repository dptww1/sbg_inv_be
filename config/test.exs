import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sbg_inv, SbgInv.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Configure your database
config :sbg_inv, SbgInv.Repo,
#  username: "postgres",
#  password: "postgres",
  database: "sbg_inv_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :sbg_inv, SbgInv.Mailer,
  adapter: Bamboo.TestAdapter

config :pbkdf2_elixir, rounds: 1
