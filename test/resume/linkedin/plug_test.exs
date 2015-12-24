defmodule Resume.Linkedin.PlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Resume.Linkedin.Plug.init([])

  test "returns ok" do
    conn = conn(:get, "/?state=111&code=ok")
    conn = Resume.Linkedin.Plug.call(conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "ok"
  end
end
