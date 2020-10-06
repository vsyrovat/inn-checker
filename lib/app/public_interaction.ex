defmodule App.PublicInteraction do
  @moduledoc """
  Context for interaction with public users through the Messages
  """

  import Ecto.Query

  alias App.PublicInteraction.Message
  alias App.Repo

  def recent_messages(limit \\ 25) when is_integer(limit) do
    Message
    |> order_by(desc: :inserted_at, desc: :id)
    |> limit(^limit)
    |> Repo.all()
    |> Enum.reverse()
  end

  def save_message(attrs) do
    Message.changeset(%Message{}, attrs)
    |> Repo.insert()
  end
end