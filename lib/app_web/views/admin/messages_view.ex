defmodule AppWeb.Admin.MessagesView do
  use AppWeb, :view

  alias App.Inn.Message

  defdelegate correct?(msg), to: Message
end
