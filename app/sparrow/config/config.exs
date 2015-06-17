# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :sparrow, Sparrow.Endpoint,
  token: System.get_env("SPARROW_TOKEN"),
  site_id: System.get_env("SPARROW_SITE_ID"),
  image_service_uri: System.get_env("IMAGE_SERVICE_URI"),
  content_service_uri: System.get_env("CONTENT_SERVICE_URI"),
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "YEJpDCK2dMImdPhxSXU7GPEFhYieF/c7RynymQ/3lJRa1tKMwjKpPxhpCsdj4mow",
  debug_errors: false,
  pubsub: [name: Sparrow.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
