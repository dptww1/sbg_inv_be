use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :sbg_inv, SbgInv.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin", cd: Path.expand("../", __DIR__)]]

# Watch static and templates for browser reloading.
config :sbg_inv, SbgInv.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :sbg_inv, SbgInv.Repo,
  adapter: Ecto.Adapters.Postgres,
#  username: "postgres",
#  password: "postgres",
  database: "sbg_inv_dev",
  hostname: "localhost",
  pool_size: 10

config :sbg_inv, SbgInv.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.davetownsend.org",
  port: 587,
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :if_available,
  ssl: false,
  retries: 1
