defmodule TermDirectory.Modules.Module do
  use Ecto.Schema
  import Ecto.Changeset
  alias TermDirectory.Repo
  alias TermDirectory.User.Teacher


  schema "modules" do
#    many_to_many :module_workers, Teacher, join_through: "module_worker"
    field :shortName, :string
    field :subject, :string
    belongs_to :responsible_teacher, Teacher

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    
    module
    |> cast(attrs, [:subject, :shortName, :responsible_teacher_id])
    |> validate_required([:subject, :shortName])
    |> foreign_key_constraint(:responsible_teacher_id)
    |> cast_assoc(:responsible_teacher)
  end

  defp get_all_teachers([]) do
    []
  end

  defp get_all_teachers(teacher_ids) do

  end

  defp loade_teacher(%{"responsible_teacher" => responsible_teacher_id} = attributes) do
    %{attributes | "responsible_teacher" => Repo.get(Teacher, responsible_teacher_id)}
  end
end
