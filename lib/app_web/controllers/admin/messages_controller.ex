defmodule AppWeb.Admin.MessagesController do
  use AppWeb, :controller

  def index(conn, _params) do
    messages = App.Inn.all_messages()
    render(conn, "messages.html", %{messages: messages})
  end
end
