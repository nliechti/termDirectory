defmodule TermDirectory.User.Teacher do
  @moduledoc """
  Schema and funtions to the teacher "object"
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias TermDirectory.Modules.Module

  schema "teachers" do
    field :firstName, :string
    field :lastName,  :string
    has_many :modules, Module

    timestamps()
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [:firstName, :lastName])
    |> validate_required([:firstName, :lastName])
  end
end
