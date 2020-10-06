defmodule AppWeb.Admin.MessagesView do
  use AppWeb, :view

  alias App.PublicInteraction.Message

  defdelegate correct?(msg), to: Message
end
