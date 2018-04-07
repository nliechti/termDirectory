defmodule TermDirectory.User.Teacher do
  use Ecto.Schema
  import Ecto.Changeset
  alias TermDirectory.Modules.Module

  schema "teachers" do
    field :firstName, :string
    field :lastName,  :string
    many_to_many :module_workers, Module, join_through: "module_worker"
    has_many :modules, Module

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:firstName, :lastName])
    |> validate_required([:firstName, :lastName])
  end
end
