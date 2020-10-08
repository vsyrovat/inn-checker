defmodule AppWeb.UserSocketTest do
  use ExUnit.Case, async: true

  defp connect(connect_info) do
    AppWeb.UserSocket.connect(nil, %Phoenix.Socket{}, connect_info)
  end

  test "detect remote ip by x_headers" do
    {:ok, socket} = connect(%{x_headers: [{"x-real-ip", "111.111.111.111"}]})
    assert socket.assigns[:remote_ip] == "111.111.111.111"
  end

  test "detect remote ip by peer_data" do
    {:ok, socket} = connect(%{peer_data: %{address: {222, 222, 222, 222}}})
    assert socket.assigns[:remote_ip] == "222.222.222.222"
  end

  test "detect remote ip by none data" do
    {:ok, socket} = connect(%{})
    assert socket.assigns[:remote_ip] == nil
  end

  test "remote ip detection priority" do
    {:ok, socket} =
      connect(%{
        peer_data: %{address: {222, 222, 222, 222}},
        x_headers: [{"x-real-ip", "111.111.111.111"}]
      })

    assert socket.assigns[:remote_ip] == "111.111.111.111"
  end
end
