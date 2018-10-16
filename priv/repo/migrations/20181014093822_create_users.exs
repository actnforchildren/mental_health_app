defmodule Afc.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :pin, :integer
      add :trusted_adult_id, references(:trusted_adults, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:trusted_adult_id])
  end
end
