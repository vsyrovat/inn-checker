defmodule App.PublicInteraction.Message do
  @moduledoc """
  Database entity representing message from the browser with ITN/TIN for check.
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias App.Checksum

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

  def correct?(%__MODULE__{} = msg) do
    case Checksum.check(msg.value) do
      {:ok, c} -> c
      _ -> false
    end
  end
end
