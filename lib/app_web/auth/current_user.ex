defmodule AppWeb.Auth.CurrentUser do
  @moduledoc """
  Plug for detect and assign current user into the conn
  """
  import Plug.Conn
  import Guardian.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = current_resource(conn)
    assign(conn, :current_user, current_user)
  end
end
