defmodule Afc.EmotionLog do
  use Ecto.Schema
  import Ecto.Changeset
  alias Afc.EctoEnum.EmotionEnum

  schema "emotion_logs" do
    field :emotion, EmotionEnum
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(emotion_log, attrs) do
    emotion_log
    |> cast(attrs, [:emotion])
    |> validate_required([:emotion])
  end
end
