defmodule AppWeb.Auth.ErrorHandler do
  # credo:disable-for-this-file Credo.Check.Design.AliasUsage
  @moduledoc """
  Error handler for authentication errors
  """
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {:unathorized, _reason}, _opts) do
    conn
    |> Phoenix.Controller.put_flash(:error, "You must be logged in to access this page")
    |> Phoenix.Controller.redirect(to: AppWeb.Router.Helpers.session_path(conn, :new))
  end

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{message: to_string(type)})
    send_resp(conn, 401, body)
  end
end
