defmodule AppWeb.SessionController do
  use AppWeb, :controller
  import AppWeb.Auth

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"login" => login, "password" => password}}) do
    case login_by_login_and_pass(conn, login, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You're now logged in!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> logout()
    |> put_flash(:info, "See you later!")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
