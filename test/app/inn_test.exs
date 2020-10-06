defmodule App.InnTest do
  use App.DataCase

  alias App.Inn
  alias App.Repo

  describe "messages" do
    alias App.Inn.Message

    @valid_attrs %{value: "some value", sender_ip: "some ip"}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inn.save_message()

      message
    end

    test "recent_messages/1 returns recent messages" do
      message = message_fixture()
      assert Inn.recent_messages() == [message]
      assert Repo.get!(Message, message.id) == message
      assert message.value == @valid_attrs.value
      assert message.sender_ip == @valid_attrs.sender_ip
    end

    test "delete_message/1 deletes message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Inn.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Inn.get_message!(message.id) end
    end
  end
end
