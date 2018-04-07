defmodule TermDirectory.Modules do
  @moduledoc """
  The Modules context.
  """

  import Ecto.Query, warn: false
  alias TermDirectory.Repo

  alias TermDirectory.Modules.Module
  alias TermDirectory.Modules.ModulePreloader
  alias TermDirectory.User.Teacher

  @doc """
  Returns the list of modules.

  ## Examples

      iex> list_modules()
      [%Module{}, ...]

  """
  def list_modules do
    Repo.all(Module)
    |> Repo.preload(:responsible_teacher)
  end

  @doc """
  Gets a single module.

  Raises `Ecto.NoResultsError` if the Module does not exist.

  ## Examples

      iex> get_module!(123)
      %Module{}

      iex> get_module!(456)
      ** (Ecto.NoResultsError)

  """
  def get_module!(id) do
    Repo.get!(Module, id)
    |> Repo.preload(:responsible_teacher)
  end

  @doc """
  Creates a module.

  ## Examples

      iex> create_module(%{field: value})
      {:ok, %Module{}}

      iex> create_module(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_module(attrs \\ %{}) do
    %Module{}
    |> Repo.preload(:responsible_teacher)
    |> Module.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a module.

  ## Examples

      iex> update_module(module, %{field: new_value})
      {:ok, %Module{}}

      iex> update_module(module, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_module(%Module{} = module, attrs) do
    module
    |> Repo.preload(:responsible_teacher)
    |> Module.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Module.

  ## Examples

      iex> delete_module(module)
      {:ok, %Module{}}

      iex> delete_module(module)
      {:error, %Ecto.Changeset{}}

  """
  def delete_module(%Module{} = module) do
    Repo.delete(module)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking module changes.

  ## Examples

      iex> change_module(module)
      %Ecto.Changeset{source: %Module{}}

  """
  def change_module(%Module{} = module) do
    Module.changeset(module, %{})
  end

  @doc """
  Searches for a module containing the searchString
  
  ## Examples

      iex> searchModule("Subject")
      [%Module{}, ...]
  """
  def searchModule(searchString \\ "") do
    fuzzySearchString = "%#{searchString}%"
    query = from module in Module,
                 where: ilike(module.subject, ^fuzzySearchString),
                 or_where: ilike(module.shortName, ^fuzzySearchString),
                 preload: :responsible_teacher

    Repo.all(query)
  end
end
