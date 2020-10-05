defmodule App.PublicInteractionTest do
  use App.DataCase

  alias App.PublicInteraction
  alias App.Repo

  describe "messages" do
    alias App.PublicInteraction.Message

    @valid_attrs %{value: "some value", sender_ip: "some ip"}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PublicInteraction.save_message()

      message
    end

    test "recent_messages/1 returns recent messages" do
      message = message_fixture()
      assert PublicInteraction.recent_messages() == [message]
      assert Repo.get!(Message, message.id) == message
      assert message.value == @valid_attrs.value
      assert message.sender_ip == @valid_attrs.sender_ip
    end
  end
end
