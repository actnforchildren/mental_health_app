defmodule Afc.Emotion.Excited do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "excited" do
    field :reason, :string

    timestamps()
  end

  @doc false
  def changeset(excited, attrs) do
    excited
    |> cast(attrs, [:reason])
  end
end
