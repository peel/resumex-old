defmodule Integration.LinkedinPlugIntegrationTest do
  use ExUnit.Case

  setup do
    Plug.Adapters.Cowboy.http Resume.Linkedin.Plug, []
    :ok
  end

  test "fetching root gets ok" do
    body = fetch('/state=aaaa&code=ok')
    assert body == 'ok'
  end

  def fetch(url) do
    base_url = 'https://localhost:4000/'
    {:ok, {{_version, 200, _reason_phrase}, _headers, body}} = :httpc.request(base_url ++ url)
    body
  end
end
