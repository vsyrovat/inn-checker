defmodule AppWeb.Admin.IpsController do
  use AppWeb, :controller

  alias App.Banhammer

  def index(conn, _params) do
    ips = Banhammer.all()
    render(conn, "ips.html", %{ips: ips})
  end
end
