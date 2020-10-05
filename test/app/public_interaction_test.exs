defmodule App.PublicInteractionTest do
  use App.DataCase

  alias App.PublicInteraction

  describe "messages" do
    @valid_attrs %{value: "some value"}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Map.get(:value)
        |> PublicInteraction.save_message()

      message
    end

    test "recent_messages/1 returns recent messages" do
      message = message_fixture()
      assert PublicInteraction.recent_messages() == [message]
    end
  end
end
