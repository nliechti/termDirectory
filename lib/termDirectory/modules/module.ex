defmodule TermDirectory.Modules.Module do
  use Ecto.Schema
  import Ecto.Changeset


  schema "modules" do
    field :responsible_teacher_id, :integer
    field :shortName, :string
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:subject, :shortName, :responsible_teacher_id])
    |> validate_required([:subject, :shortName, :responsible_teacher_id])
  end
end
