defmodule TermDirectory.Modules.Fact do
  use Ecto.Schema
  import Ecto.Changeset

  alias TermDirectory.Modules
  alias TermDirectory.Repo
  
  schema "facts" do
    field :value, :string
    field :remark, :string
    belongs_to :module, Modules.Module
    belongs_to :fact_type, Modules.FactType
    
    timestamps()
  end

  @doc false
  def changeset(fact, attrs) do
    fact
    |> Repo.preload(:fact_type)
    |> Repo.preload(:module)
    |> cast(attrs, [:value, :remark, :fact_type_id, :module_id])
    |> validate_required([:value, :remark, :fact_type_id, :module_id])
    |> foreign_key_constraint(:fact_type)
    |> foreign_key_constraint(:module)
    |> cast_assoc(:fact_type)
    |> cast_assoc(:module)
  end
end