defmodule AppWeb.LayoutView do
  use AppWeb, :view

  defdelegate admin?(conn), to: AppWeb.Auth
end
