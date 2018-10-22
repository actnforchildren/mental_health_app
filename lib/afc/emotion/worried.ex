defmodule Afc.Emotion.Worried do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  schema "worried" do
    field :friends, :boolean, default: false
    field :school, :boolean, default: false
    field :"family/home", :boolean, default: false
    field :community, :boolean, default: false
    field :bullying, :boolean, default: false
    field :exams, :boolean, default: false
    field :teachers, :boolean, default: false
    field :classwork, :boolean, default: false
    field :homework, :boolean, default: false
    field :else, :boolean, default: false
    field :reason, :string

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [
      :friends, :school, :"family/home", :community, :bullying, :exams,
      :teachers, :classwork, :homework, :else, :reason
    ])
  end
end
