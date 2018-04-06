defmodule TermDirectory.Modules.Module do
  use Ecto.Schema
  import Ecto.Changeset


  schema "modules" do
    many_to_many :module_workers, TermDirectory.User.Teacher, join_through: "module_worker"
    field :shortName, :string
    field :subject, :string
    belongs_to :responsible_teacher, TermDirectory.User.Teacher

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:subject, :shortName])
    |> validate_required([:subject, :shortName])
    |> cast_assoc(:responsible_teacher)
    |> cast_assoc(:module_workers)
  end
end
