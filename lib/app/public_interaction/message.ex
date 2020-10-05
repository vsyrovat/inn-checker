defmodule App.PublicInteraction.Message do
  @moduledoc """
  Database entity representing message from the browser with ITN/TIN for check.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
