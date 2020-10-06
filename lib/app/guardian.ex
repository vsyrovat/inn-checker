defmodule App.Guardian do
  @moduledoc """
  App-implementation of Guardian behaviour
  """
  use Guardian, otp_app: :app

  alias App.Auth.User
  alias App.Repo

  @impl Guardian
  def subject_for_token(%User{} = user, _claims), do: {:ok, "User:#{user.id}"}
  def subject_for_token(_, _), do: {:error, "Unknown resource type"}

  @impl Guardian
  def resource_from_claims(%{"sub" => "User:" <> id}), do: {:ok, Repo.get(User, id)}
  def resource_from_claims(_), do: {:error, "Unknown resource type"}
end
