# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :jamjaman,
  ecto_repos: [Jamjaman.Repo]

# Configures the endpoint
config :jamjaman, JamjamanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U6rb9AJCDoSe1LtiNJOsLGzUW8+S60TApNALK1lnjems+w+yx3pcMD2d4dskTxax",
  render_errors: [view: JamjamanWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Jamjaman.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configures Guardian
config :jamjaman, Jamjaman.Auth.Guardian,
  issuer: "jamjaman",
  secret_key: "HNinpKh9Ne3tr8BpjCpAEh0xzCqTIG3PWsfkR2AtzvUaRIpbs6oIQ9RcmjmGPekJ"

config :jamjaman, Jamjaman.Auth.AuthAccessPipeline,
  module: Jamjaman.Auth.Guardian,
  error_handler: Jamjaman.Auth.AuthErrorHandler

config :jamjaman, Jamjaman.User.Guardian,
  issuer: "jamjaman",
  secret_key: "QWh0IThvjpSdcB44igc3xE4ADLomYx9c9iUg13Qg5foDiKapb9gGY3NzAy6J/AFr"

config :jamjaman, Jamjaman.User.AuthAccessPipeline,
  module: Jamjaman.User.Guardian,
  error_handler: Jamjaman.User.AuthErrorHandler
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
