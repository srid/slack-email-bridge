# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :slack_email_bridge,
  port: System.get_env("PORT")

config :slack_email_bridge,
  slack_webhook: System.get_env("SLACK_WEBHOOK"),
  suppress_body_from: System.get_env("SUPPRESS_BODY_FROM")

import_config "#{Mix.env}.exs"
