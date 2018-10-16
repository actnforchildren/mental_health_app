defmodule Afc.Repo.Migrations.CreateTrustedAdults do
  use Ecto.Migration

  def change do
    create table(:trusted_adults) do
      add :email, :string

      timestamps()
    end

  end
end
