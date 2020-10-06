defmodule AppWeb.FallbackController do
  use Phoenix.Controller

  def call(conn, :unauthorized) do
    send_resp(conn, 403, "Unauthorized")
  end
end
