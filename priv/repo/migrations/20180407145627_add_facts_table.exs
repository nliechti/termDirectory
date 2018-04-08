defmodule TermDirectory.Repo.Migrations.AddFactsTable do
  use Ecto.Migration

  def change do
    create table(:fact_types) do
      add :short_name, :string

      timestamps()
    end

    create table(:facts) do
      add :value, :string
      add :remark, :string
      add :module_id, references(:modules), null: false
      add :fact_type_id, references(:fact_types), null: false

      timestamps()
    end
  end
end
