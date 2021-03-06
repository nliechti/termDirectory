defmodule TermDirectory.Modules.Module do
  @moduledoc """
  Schema and funtions to the module "object"
  """
  
  use Ecto.Schema
  import Ecto.Changeset
  alias TermDirectory.Repo
  alias TermDirectory.User.Teacher
  alias TermDirectory.Modules
  
  require Logger


  schema "modules" do
    many_to_many :module_workers, Teacher, join_through: Modules.ModuleWorker, on_replace: :delete
    field :shortName, :string
    field :subject, :string
    belongs_to :responsible_teacher, Teacher
    has_many :facts, Modules.Fact

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
    |> validate_required([:subject, :shortName, :responsible_teacher_id])
    |> foreign_key_constraint(:responsible_teacher_id)
    |> cast_assoc(:responsible_teacher)
    |> put_assoc(:module_workers, preloaded_attrs["module_workers"], required: false)
  end

  # Preload needed attributes to the module that should be loaded
  defp preload_attrs(attrs) do
    attrs
    |> preload_module_workers
  end
  
  # Preload the module workers that belong to the given module
  defp preload_module_workers(%{"module_workers" => module_worker_ids} = attrs) do
    Map.put(attrs, "module_workers", preload_module_worker([], module_worker_ids))
  end

  # Is used when an no module_worker attribute is given, 
  # as put_assoc expects an emtpy list in this casse
  defp preload_module_workers(attrs) do
    Map.put(attrs, "module_workers", [])
  end

  defp preload_module_worker(module_workers, [module_worker_id | module_workers_ids]) do
    module_workers
    |> List.insert_at(0, Repo.get(Teacher, module_worker_id))
    |> preload_module_worker(module_workers_ids)
  end
  
  defp preload_module_worker(module_workers, []) do
    module_workers
  end
end
