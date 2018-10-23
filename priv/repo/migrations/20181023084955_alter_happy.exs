defmodule Afc.Repo.Migrations.AlterHappy do
  use Ecto.Migration

  def change do
    alter table(:happy) do
      add :friends, :boolean, default: false, null: false
      add :school, :boolean, default: false, null: false
      add :"family/home", :boolean, default: false, null: false
      add :community, :boolean, default: false, null: false
      add :bullying, :boolean, default: false, null: false
      add :exams, :boolean, default: false, null: false
      add :teachers, :boolean, default: false, null: false
      add :classwork, :boolean, default: false, null: false
      add :homework, :boolean, default: false, null: false
      add :else, :boolean, default: false, null: false
    end
  end
end
