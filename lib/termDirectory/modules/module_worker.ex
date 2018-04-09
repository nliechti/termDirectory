defmodule TermDirectory.Modules.ModuleWorker do
  @moduledoc """
  This schema is only needed because the timestamp on insert doesn't work otherwise
  """
  use Ecto.Schema
  alias TermDirectory

  # Generate no primary key as it is an cross table only
  @primary_key false
  schema "module_workers" do
    belongs_to :teacher, User.Teacher
    belongs_to :module, Modules.Module
    timestamps()
  end
end