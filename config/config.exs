# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :any_gym_planner,
  ecto_repos: [AnyGymPlanner.Repo]

# Configures the endpoint
config :any_gym_planner, AnyGymPlannerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ru5v5ZdxP0DB+CYWsX7cx+gO9iXzNzmvC03yxWp3vZFFbckHKX8e3X0yF7CNwNKG",
  render_errors: [view: AnyGymPlannerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AnyGymPlanner.PubSub,
  live_view: [signing_salt: "GveZsnim"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
