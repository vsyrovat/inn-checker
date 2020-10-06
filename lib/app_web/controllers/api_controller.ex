defmodule AppWeb.ApiController do
  use AppWeb, :controller

  alias App.PublicInteraction
  alias AppWeb.Auth
  alias AppWeb.Endpoint

  action_fallback AppWeb.FallbackController

  def delete(conn, %{"id" => id} = _params) do
    if Auth.operator?(conn) do
      message = PublicInteraction.get_message!(id)
      PublicInteraction.delete_message(message)
      Endpoint.broadcast("inn:main", "delete_message", %{id: id})
      json(conn, %{success: true})
    else
      :unauthorized
    end
  end
end
