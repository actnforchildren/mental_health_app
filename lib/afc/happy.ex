defmodule Afc.Happy do
  use Ecto.Schema
  import Ecto.Changeset


  schema "happy" do
    field :reason_text, :string

    timestamps()
  end

  @doc false
  def changeset(happy, attrs) do
    happy
    |> cast(attrs, [:reason_text])
  end
end
