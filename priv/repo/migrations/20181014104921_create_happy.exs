defmodule Afc.Repo.Migrations.CreateHappy do
  use Ecto.Migration

  def change do
    create table(:happy) do
      add :reason, :text

      timestamps()
    end

  end
end
