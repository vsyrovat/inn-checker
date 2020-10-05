defmodule App.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :value, :string

      timestamps()
    end
  end
end
