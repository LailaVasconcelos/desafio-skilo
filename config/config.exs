# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :banco,
  ecto_repos: [Banco.Repo]

# Configures the endpoint
config :banco, BancoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZAoJoxhwtQCymxkiaeVp9SpQuLKUo29rDX5kFBL77qQMh2D/Ujab9TinqdE2iTZR",
  render_errors: [view: BancoWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Banco.PubSub,
  live_view: [signing_salt: "38jJoSTh"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

## Ecto defaults
config :banco, Banco.Repo,
  migration_primary_key: [name: :uuid, type: :binary_id],
  migration_foreign_key: [column: :uuid, type: :binary_id]
