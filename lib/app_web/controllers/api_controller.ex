defmodule AppWeb.ApiController do
  use AppWeb, :controller

  alias App.Banhammer
  alias App.PublicInteraction
  alias AppWeb.Auth
  alias AppWeb.Endpoint

  action_fallback AppWeb.FallbackController

  def delete_message(conn, %{"id" => id} = _params) do
    if Auth.operator?(conn) do
      message = PublicInteraction.get_message!(id)
      PublicInteraction.delete_message(message)
      Endpoint.broadcast("inn:main", "delete_message", %{id: id})
      json(conn, %{success: true})
    else
      :unauthorized
    end
  end

  def ban_ip(conn, %{"ip" => ip} = _params) do
    if Auth.admin?(conn) do
      Banhammer.ban(ip)
      json(conn, %{success: true})
    else
      :unauthorized
    end
  end

  def unban_ip(conn, %{"ip" => ip} = _params) do
    if Auth.admin?(conn) do
      Banhammer.unban(ip)
      json(conn, %{success: true})
    else
      :unauthorized
    end
  end
end
