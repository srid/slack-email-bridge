defmodule SlackEmailBridge.Slack do
  require Logger

  def send_message(message_hash) do
    # POST https://hooks.slack.com/services/...
    # Content-type: application/json
    # {
    #   "text": "This is a line of text.\nAnd this is another one."
    # }
    slack_webhook = Application.get_env(:slack_email_bridge, :slack_webhook)

    body = Poison.encode!(message_hash)
    Logger.info "Sending to Slack: #{body}"

    HTTPoison.post!(slack_webhook, body, [{"Accept", "application/json"}])
  end

end
