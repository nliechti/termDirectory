defmodule TermDirectory.Modules.ModulePreloader do
  alias TermDirectory.Repo

  alias TermDirectory.Modules.Module

  def preload_module(module, attrs) do
    responsible_teacher = Repo.get!(TermDirectory.User.Teacher, attrs["responsible_teacher"])
    module_worker = [];
    Enum.each attrs["module_worker"], fn moduleWorkerId ->
      ^module_worker = [module_worker ++ Repo.get!(TermDirectory.User.Teacher, moduleWorkerId)]
    end
    newModule = %Module{module | responsible_teacher: responsible_teacher, module_workers: module_worker}
    newModule
  end
  
  defp preload_module_worker([module_worker_id | module_workers_ids], module_workers) do
    
    preload_module_worker(module_worker_ids)
  end

  defp preload_module_worker([], module_workers) do
    module_workers
  end
end