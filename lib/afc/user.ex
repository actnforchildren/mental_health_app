defmodule Afc.User do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "users" do
    field :pin, :integer
    field :username, :string
    field :trusted_adult_id, :id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :pin])
    |> validate_required([:username, :pin])
  end
end
