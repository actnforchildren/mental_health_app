defmodule Afc.Repo.Migrations.CreateUnsure do
  use Ecto.Migration

  def change do
    create table(:unsure) do
      add :reason, :text

      timestamps()
    end
  end
end
