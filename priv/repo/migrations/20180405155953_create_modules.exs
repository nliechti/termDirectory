defmodule TermDirectory.Repo.Migrations.CreateModules do
  use Ecto.Migration

  def change do
    create table(:modules) do
      add :subject, :string
      add :shortName, :string
      add :responsible_teacher_id, :integer

      timestamps()
    end

  end
end
