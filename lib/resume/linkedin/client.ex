defmodule Resume.Linkedin.Client do
  use OAuth2.Strategy

  #Public API
  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: "gli8cbzlbgad",
      client_secret: "tHZ2XzmpuVRsEZD3",
      redirect_uri: "https://127.0.0.1:4000",
      authorize_url: "https://www.linkedin.com/uas/oauth2/authorization",
      token_url: "https://linkedin.com/uas/oauth2/accessToken",
    ])
  end

  def authorize_url!(params \\ []) do
    client()
    |> put_param(:scope, "r_basicprofile")
    |> put_param(:state, "p33l7h3k1n6")
    |> OAuth2.Client.authorize_url!(params)
  end

  # you can pass options to the underlying http library via `options` parameter
  def get_token!(params \\ [], headers \\ [], options \\ []) do
    client()
    |> put_param(:grant_type, "authorization_code")
    |> OAuth2.Client.get_token!(params, headers, options)
  end

  # Strategy Callbacks
  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end
