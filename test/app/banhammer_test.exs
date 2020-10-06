defmodule App.BanhammerTest do
  use ExUnit.Case, async: true

  alias App.Banhammer

  @ip "888.888.888.888"

  describe "ips" do
    test "banned should be banned and unbanned when unbanned" do
      refute Banhammer.banned?(@ip)
      Banhammer.ban(@ip)
      assert Banhammer.banned?(@ip)
      Banhammer.unban(@ip)
      refute Banhammer.banned?(@ip)
    end
  end
end
