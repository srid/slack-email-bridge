defmodule SlackEmailBridge.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Slack Email Bridge")
  end

end
