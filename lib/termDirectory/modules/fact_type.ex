defmodule TermDirectory.Modules.FactType do
  @moduledoc """
  Schema and funtions to the fact type "object"
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "fact_types" do
    field :short_name
    has_many :facts, TermDirectory.Modules.Fact

    timestamps()
  end

  @doc false
  def changeset(fact_type, attrs) do
    fact_type
    |> cast(attrs, [:short_name])
    |> validate_required([:short_name])
  end

end