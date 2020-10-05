defmodule App.Repo.Migrations.AddIpToMessages do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :sender_ip, :string
    end
  end
end
