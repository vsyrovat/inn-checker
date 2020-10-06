defmodule App.Auth.User do
  @moduledoc """
  Entity represents user (admin, operator)
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :is_admin, :boolean, default: false
    field :is_operator, :boolean, default: false
    field :login, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @required ~w(login)a
  @optional ~w(is_admin is_operator)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(Map.delete(attrs, :login), @required ++ @optional)
    |> validate_required(List.delete(@required, :login))
    |> validate_not_nil([:is_admin, :is_operator])
    |> unique_constraint(:login)
    |> cast_password(attrs)
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:login])
    |> validate_required([:login])
    |> changeset(attrs)
  end

  defp cast_password(changeset, attrs) do
    changeset
    |> cast(attrs, [:password], [])
    |> validate_length(:password, min: 5, max: 30)
    |> hash_password()
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        change(changeset, password_hash: Argon2.hash_pwd_salt(password), password: nil)

      _ ->
        changeset
    end
  end

  defp validate_not_nil(changeset, fields) do
    Enum.reduce(fields, changeset, fn field, changeset ->
      if get_field(changeset, field) == nil do
        add_error(changeset, field, "can't be nil")
      else
        changeset
      end
    end)
  end

  defdelegate verify_pass(pass, hash), to: Argon2
  defdelegate no_user_verify(), to: Argon2
end
