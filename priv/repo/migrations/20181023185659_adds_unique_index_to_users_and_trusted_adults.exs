defmodule Afc.Repo.Migrations.AlterTrustedAdultsUniqueIndex do
  use Ecto.Migration

  def change do
    create unique_index(:trusted_adults, [:email])
    create unique_index(:users, [:username])
  end
end
