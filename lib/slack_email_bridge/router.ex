defmodule SlackEmailBridge.Router do
  use Plug.Router
  use Plug.ErrorHandler
  require Logger

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json, :urlencoded],
    pass:  ["text/*"],
    json_decoder: Poison

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Slack Email Bridge")
  end

  post "/incoming_email" do
    conn.params
    |> parse_email
    |> SlackEmailBridge.Slack.format_email_for_slack
    |> SlackEmailBridge.Slack.send_message

    send_resp(conn, 200, "Ok")
  end

  def parse_email(postmark_hash) do
    sender = postmark_hash["FromFull"]["Name"]
    subject = postmark_hash["Subject"]

    body = if suppress_body_from?(sender) do
      "... _snipped_ ..."
    else
      postmark_hash["TextBody"]
    end

    {sender, subject, body}
  end

  defp suppress_body_from?(sender) do
    case Application.get_env(:slack_email_bridge, :suppress_body_from) do
      nil -> false
      ""  -> false
      s   -> String.contains?(sender, s)
    end
  end

end
