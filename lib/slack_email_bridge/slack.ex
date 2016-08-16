defmodule SlackEmailBridge.Slack do
  require Logger

  def send_message(message_hash) do
    slack_webhook = Application.get_env(:slack_email_bridge, :slack_webhook)
    Logger.info "Sending to Slack"

    body = Poison.encode!(message_hash)
    HTTPoison.post!(slack_webhook, body, [{"Accept", "application/json"}])
  end

  def format_email_for_slack({sender, subject, body}) do
    %{"username" => sender,
      "icon_emoji" => ":incoming_envelope:",
      "text" => "*#{subject}*",
      "attachments" => [
        %{"text" => body,
          "mrkdwn_in" => ["text", "pretext"]
         }
      ]
    }
  end

end
