defmodule TermDirectory.User.Teacher do
  use Ecto.Schema
  import Ecto.Changeset


  schema "teachers" do
    field :firstName, :string
    field :lastName,  :string

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:firstName, :lastName])
    |> validate_required([:firstName, :lastName])
  end
end
