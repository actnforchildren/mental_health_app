defmodule Afc.Trusted_adult do
  use Ecto.Schema
  import Ecto.Changeset


  schema "trusted_adults" do
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(trusted_adult, attrs) do
    trusted_adult
    |> cast(attrs, [:email])
    |> validate_required([:email])
  end
end
