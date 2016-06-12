defmodule HelloPlugTest do

  use ExUnit.Case
  use Plug.Test

  doctest HelloPlug

  test "returns a user" do
    conn = conn(:get, "/users/1")
    conn = HelloPlug.call(conn, [])

    assert conn.state == :sent
    assert conn.status == 200
    assert String.match?(conn.resp_body, ~r/User Information Page/)
  end
end
