defmodule Afc.Repo.Migrations.CreateEmotionLogs do
  use Ecto.Migration

  def change do
    create table(:emotion_logs) do
      add :emotion, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:emotion_logs, [:user_id])
  end
end
