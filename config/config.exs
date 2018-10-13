# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :afc,
  ecto_repos: [Afc.Repo]

# Configures the endpoint
config :afc, AfcWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LA+CaY7hG93NGEN7LKUPuSbtPJBoiw56kk2WfwT9sy/J9QZjcehCpkHu9NW8rzW5",
  render_errors: [view: AfcWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Afc.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :pre_commit,
  commands: ["test", "credo --strict", "coveralls"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
