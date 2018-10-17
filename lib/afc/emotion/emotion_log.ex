defmodule Afc.Emotion.EmotionLog do
  use Ecto.Schema
  import Ecto.Changeset
  alias Afc.{EctoEnum.EmotionEnum, User}

  schema "emotion_logs" do
    field :emotion, EmotionEnum
    field :emotion_id, :id
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(emotion_log, attrs) do
    emotion_log
    |> cast(attrs, [:emotion, :emotion_id])
    |> validate_required([:emotion, :emotion_id])
  end
end
