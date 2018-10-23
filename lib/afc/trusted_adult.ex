defmodule Afc.TrustedAdult do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

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
