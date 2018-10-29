defmodule Afc.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Afc.{TrustedAdult}

  @moduledoc false

  schema "users" do
    field :pin, :integer
    field :username, :string
    belongs_to :trusted_adult, TrustedAdult

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :pin])
    |> validate_required([:username, :pin])
  end
end
