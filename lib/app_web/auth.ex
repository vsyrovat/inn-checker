defmodule AppWeb.Auth do
  # credo:disable-for-this-file Credo.Check.Design.AliasUsage
  @moduledoc """
  Login/logout applicable to web requests
  """
  alias App.Auth.User
  alias App.Repo

  defp login(conn, user) do
    App.Guardian.Plug.sign_in(conn, user)
  end

  def login_by_login_and_pass(conn, login, password) do
    user = Repo.get_by(User, login: login)

    cond do
      user && User.verify_pass(password, user.password_hash) ->
        {:ok, login(conn, user)}

      user ->
        {:error, :unathorized, conn}

      true ->
        User.no_user_verify()
        {:error, :no_resoruce_found, conn}
    end
  end

  def logout(conn) do
    App.Guardian.Plug.sign_out(conn)
  end
end
