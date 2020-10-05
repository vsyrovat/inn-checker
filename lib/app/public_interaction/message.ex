defmodule App.PublicInteraction.Message do
  @moduledoc """
  Database entity representing message from the browser with ITN/TIN for check.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :value, :string
    field :sender_ip, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:value, :sender_ip])
    |> validate_required([:value])
  end
end
