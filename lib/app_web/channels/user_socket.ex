defmodule AppWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "inn:main", AppWeb.MainChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(_params, socket, connect_info) do
    socket = assign(socket, :remote_ip, remote_ip(connect_info))
    {:ok, socket}
  end

  defp remote_ip(connect_info) do
    remote_ip_by_header(connect_info, "x-real-ip") ||
      remote_ip_by_peer_data(connect_info)
  end

  defp remote_ip_by_header(%{x_headers: x_headers}, header_name), do: find_header(x_headers, header_name)
  defp remote_ip_by_header(_, _), do: nil

  defp find_header([{key, val} | tail], header_name) do
    if key == header_name, do: val, else: find_header(tail, header_name)
  end

  defp find_header([], _), do: nil

  defp remote_ip_by_peer_data(%{peer_data: %{address: nil}}), do: nil
  defp remote_ip_by_peer_data(%{peer_data: %{address: address}}), do: :inet_parse.ntoa(address) |> to_string()
  defp remote_ip_by_peer_data(_), do: nil

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     AppWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(_socket), do: nil
end
