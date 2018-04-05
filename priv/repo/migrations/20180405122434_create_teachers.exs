defmodule TermDirectory.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :firstName, :string

      timestamps()
    end

  end
end
