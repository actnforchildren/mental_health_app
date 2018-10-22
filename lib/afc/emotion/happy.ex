defmodule Afc.Emotion.Happy do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "happy" do
    field :reason, :string

    timestamps()
  end

  @doc false
  def changeset(happy, attrs) do
    happy
    |> cast(attrs, [:reason])
  end
end
