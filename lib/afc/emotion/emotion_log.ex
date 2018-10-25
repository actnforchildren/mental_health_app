defmodule Afc.Emotion.EmotionLog do
  use Ecto.Schema
  import Ecto.Changeset
  alias Afc.{EctoEnum.EmotionEnum, User}

  @moduledoc false

  schema "emotion_logs" do
    field :emotion, EmotionEnum
    field :emotion_id, :id
    field :shared, :boolean, default: false
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(emotion_log, attrs) do
    emotion_log
    |> cast(attrs, [:emotion, :emotion_id, :shared])
    |> validate_required([:emotion, :emotion_id])
  end
end
