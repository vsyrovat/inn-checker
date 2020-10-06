defmodule AppWeb.PageView do
  use AppWeb, :view

  alias AppWeb.Auth

  defdelegate operator?(conn), to: Auth
  defdelegate admin?(conn), to: Auth
end
