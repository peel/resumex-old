defmodule Resume.Linkedin.Plug do
  use Plug.Router
  use Plug.Debugger, otp_app: :resume
  import Plug.Conn
  alias Resume.Linkedin.Client

  plug Plug.Logger
  plug :match
  plug :dispatch

  def start_link() do
    {:ok, _} = Plug.Adapters.Cowboy.https __MODULE__, [],
    port: 4000,
    password: "cowboy",
    otp_app: :resume,
    keyfile: "priv/ssl/key.pem",
    certfile: "priv/ssl/cert.pem"
  end

  get "/" do
    %{"code" => code, "state" => _state} = fetch_query_params(conn).params
    token = Client.get_token!(code: code, grant_type: "authorization_code")
    {:ok, %{body: user}} = OAuth2.AccessToken.get(token, "https://api.linkedin.com/v1/people/~?format=json")
    send_resp(conn, 200, "#{user}")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
