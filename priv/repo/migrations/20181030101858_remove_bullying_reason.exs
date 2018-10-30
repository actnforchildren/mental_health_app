defmodule Afc.Repo.Migrations.RemoveBullyingReason do
  use Ecto.Migration

  def change do
    alter table(:excited) do
      remove :bullying
    end

    alter table(:happy) do
      remove :bullying
    end
  end
end
