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
  secret_key_base: "oTbhiz2tZuc4zX3vuclM/o+mgWJXi7rkqi1NWCF2ICboRbEriudUTxs+ogkcI2Ur",
  render_errors: [view: AfcWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Afc.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
