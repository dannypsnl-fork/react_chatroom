# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :react_chatroom,
  ecto_repos: [ReactChatroom.Repo]

# Configures the endpoint
config :react_chatroom, ReactChatroomWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tLa3AO1zlspSYxaK2EJvsERAowfApQ2AQHbQj0WOFDiGxZj3n8uCJ6lKqy04LpG7",
  render_errors: [view: ReactChatroomWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ReactChatroom.PubSub,
  live_view: [signing_salt: "YHumDVfJ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
