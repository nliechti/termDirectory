defmodule TermDirectory.Repo.Migrations.CreateModuleWorkers do
  use Ecto.Migration

  def change do
    create table(:module_workers, primary_key: false) do
      add :teacher_id, references(:teachers, on_delete: :nothing)
      add :module_id, references(:modules, on_delete: :nothing)

      timestamps()
    end

    create index(:module_workers, [:teacher_id])
    create index(:module_workers, [:module_id])
  end
end
