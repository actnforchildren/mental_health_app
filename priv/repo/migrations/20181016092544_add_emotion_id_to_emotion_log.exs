defmodule Afc.Repo.Migrations.AddEmotionIdToEmotionLog do
  use Ecto.Migration

  def change do
    alter table(:emotion_logs) do
      add :emotion_id, :integer
    end
  end
end
