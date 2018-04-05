defmodule TermDirectory.Repo.Migrations.AddLastName do
  use Ecto.Migration

  def change do
    alter table(:teachers) do
      add :lastName, :text
    end
  end
end
