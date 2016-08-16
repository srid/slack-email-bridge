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
    IO.inspect conn.params
    send_resp(conn, 200, "Ok")
  end
end
