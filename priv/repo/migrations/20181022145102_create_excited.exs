defmodule Afc.Repo.Migrations.CreateExcited do
  use Ecto.Migration

  def change do
    create table(:excited) do
      add :reason, :text

      timestamps()
    end

  end
end
