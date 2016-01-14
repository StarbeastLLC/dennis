# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :dennis, Dennis.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "wS/zB3ouaF4Frp8kxeM0TAvvsT9SZLHnAZ7bR1Imbfq9tcMM3GRNDHq5pIpKt5VM",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Dennis.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Mailgun credentials
config :dennis, 
  mailgun_domain: "https://api.mailgun.net/v3/sandbox9ddf700296ad4bf0a817cedfe2a09d99.mailgun.org",
  mailgun_key: "key-0c056f5ddfd814fe0e9a1b831c26b561"


# Configures Stripe
config :dennis, :stripe, %{
  credentials: {"sk_test_BQokikJOvBiI2HlWgH4olfQ2", ""},
  default_currency: "USD",
  data_key: "pk_test_GonGFcmx47wfCYHhs9Atv1nq",
  # The amount MyMiles gets for each donation
  # (in cents)
  application_fee: 0
}

# Facebook Application
config :dennis, :facebook, %{
  app_id: 974600335935982
}

# Amazon S3 
config :arc,
  access_key_id: "AKIAINRH74724VKXSUQQ",
  secret_access_key: "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",
  bucket: "mymiles",
  asset_host: "https://mymiles.s3.amazonaws.com"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
