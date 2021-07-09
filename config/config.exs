# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :sbg_inv, SbgInv.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ygLXFi4UG89ZvH/nn1SWdMNw2z4HmJrwj5suStMwI3rqvqD/l1WzaJTHM7ifx+1r",
  render_errors: [view: SbgInv.Web.ErrorView, accepts: ~w(json)],
  pubsub_server: SbgInv.Web.PubSub

config :sbg_inv,
       namespace: SbgInv.Web

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false,
  json_library: Jason

config :phoenix, :json_library, Jason

config :phoenix, :format_encoders,
  "json-api": Jason

config :sbg_inv,
       ecto_repos: [SbgInv.Repo]

config :sbg_inv,
       namespace: SbgInv.Web

config :bamboo,
       :json_library, Jason
