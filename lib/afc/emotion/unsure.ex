defmodule Afc.Emotion.Unsure do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "unsure" do
    field :reason, :string

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:reason])
  end
end
