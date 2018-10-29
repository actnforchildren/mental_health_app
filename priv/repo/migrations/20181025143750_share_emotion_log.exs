defmodule Afc.Repo.Migrations.ShareEmotionLog do
  use Ecto.Migration

  def change do
    alter table(:emotion_logs) do
      add :shared, :boolean, default: false, null: false
    end
  end
end
