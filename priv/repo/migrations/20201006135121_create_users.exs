defmodule App.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string
      add :password_hash, :string
      add :is_admin, :boolean, default: false, null: false
      add :is_operator, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:login])
  end
end
