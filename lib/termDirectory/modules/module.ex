defmodule TermDirectory.Modules.Module do
  use Ecto.Schema
  import Ecto.Changeset
  alias TermDirectory.Repo
  alias TermDirectory.User.Teacher
  
  require Logger


  schema "modules" do
    many_to_many :module_workers, Teacher, join_through: TermDirectory.Modules.ModuleWorker
    field :shortName, :string
    field :subject, :string
    belongs_to :responsible_teacher, Teacher

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    preloaded_attrs = preload_attrs(attrs)
    preloaded_attrs |> inspect |> Logger.info
    module
    |> Repo.preload(:responsible_teacher)
    |> Repo.preload(:module_workers)
    |> cast(preloaded_attrs, [:subject, :shortName, :responsible_teacher_id])
    |> validate_required([:subject, :shortName])
    |> foreign_key_constraint(:responsible_teacher_id)
    |> cast_assoc(:responsible_teacher)
    |> put_assoc(:module_workers, preloaded_attrs["module_workers"])
  end

  defp preload_attrs(attrs) do
    attrs
    |> preload_module_workers
  end
  
  defp preload_module_workers(%{"module_workers" => module_worker_ids} = attrs) do
    Map.put(attrs, "module_workers", preload_module_worker([], module_worker_ids))
  end
  
  defp preload_module_workers(attrs), do: attrs

  defp preload_module_worker(module_workers, [module_worker_id | module_workers_ids]) do
    module_workers
    |> List.insert_at(0, Repo.get(Teacher, module_worker_id))
    |> preload_module_worker(module_workers_ids)
  end

  defp preload_module_worker(module_workers, []) do
    module_workers
  end

  defp loade_teacher(%{"responsible_teacher" => responsible_teacher_id} = attributes) do
    %{attributes | "responsible_teacher" => Repo.get(Teacher, responsible_teacher_id)}
  end
end
