defmodule SlackEmailBridge do
  use Application
  require Logger

  def start(_type, _arg) do
    import Supervisor.Spec, warn: false

    port = Application.get_env(:slack_email_bridge, :port)
    |> String.to_integer
    Logger.info "Starting on port #{port}"

    children = [
      Plug.Adapters.Cowboy.child_spec(
        :http, SlackEmailBridge.Router, [], [port: port])
    ]

    opts = [strategy: :one_for_one, name: SlackEmailBridge.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
