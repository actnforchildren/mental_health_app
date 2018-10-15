defmodule Afc.Repo.Migrations.CreateHappy do
  use Ecto.Migration

  def change do
    create table(:happy) do
      add :reason_text, :string

      timestamps()
    end

  end
end
