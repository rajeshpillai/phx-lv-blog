# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lv_demo,
  ecto_repos: [LvDemo.Repo]

# Configures the endpoint
config :lv_demo, LvDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "k38qfjkVshPEq2Kfs3Xuxw1ib2cAkAgC9pasz8rLQWRLfNhmaV6QBLUwQSjFIgLg",
  render_errors: [view: LvDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LvDemo.PubSub,
  live_view: [signing_salt: "AmqWwb5o"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
