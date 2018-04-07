defmodule TermDirectory.Modules.ModulePreloader do
  alias TermDirectory.Repo

  alias TermDirectory.Modules.Module
  require Logger
  
#  def preload_module(module, attrs) do
#    responsible_teacher = Repo.get!(TermDirectory.User.Teacher, attrs["responsible_teacher"])
#    module_worker = preload_module_worker([], attrs["module_workers"])
#    newModule = %Module{module | responsible_teacher: responsible_teacher, module_workers: module_worker}
#    newModule |> inspect |> Logger.debug
#    newModule
#  end
#
#
#  defp preload_module_worker(module_worker_list, [module_worker_id | module_worker_ids]) do
#    [Repo.get(TermDirectory.User.Teacher, module_worker_id) | module_worker_list]
#    |> preload_module_worker(module_worker_ids)
#  end
#
#  defp preload_module_worker(module_workers, []) do
#    module_workers
#  end
#
#  defp preload_module_worker(module_workers, nil) do
#    module_workers
#  end
end