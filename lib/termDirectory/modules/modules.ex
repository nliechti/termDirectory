defmodule TermDirectory.Modules do
  @moduledoc """
  The Modules context.
  """

  import Ecto.Query, warn: false
  alias TermDirectory.Repo

  alias TermDirectory.Modules.Module
  alias TermDirectory.Modules.Fact
  alias TermDirectory.Modules.FactType

  @doc """
  Returns the list of modules.

  ## Examples

      iex> list_modules()
      [%Module{}, ...]

  """
  def list_modules do
    Repo.all(Module)
    |> Repo.preload(:responsible_teacher)
    |> Repo.preload(:module_workers)
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
    |> Repo.preload(:module_workers)
    |> Repo.preload(:responsible_teacher)
    |> Repo.preload(:facts)
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

  @doc """
  Returns the list of facts.

  ## Examples

      iex> list_facts()
      [%Fact{}, ...]

  """
  def list_facts do
    Repo.all(Fact)
  end

  @doc """
  Gets a single fact.

  Raises `Ecto.NoResultsError` if the Fact does not exist.

  ## Examples

      iex> get_fact!(123)
      %Fact{}

      iex> get_fact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fact!(id) do
    Repo.get!(Fact, id)
  end

  @doc """
  Creates a fact.

  ## Examples

      iex> create_fact(%{field: value})
      {:ok, %Fact{}}

      iex> create_fact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fact(attrs \\ %{}) do
    %Fact{}
    |> Fact.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fact.

  ## Examples

      iex> update_fact(fact, %{field: new_value})
      {:ok, %Fact{}}

      iex> update_fact(fact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fact(%Fact{} = fact, attrs) do
    fact
    |> Fact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Fact.

  ## Examples

      iex> delete_fact(fact)
      {:ok, %Fact{}}

      iex> delete_fact(fact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fact(%Fact{} = fact) do
    Repo.delete(fact)
  end

  def search_fact(searchString \\ "") do
    fuzzySearchString = "%#{searchString}%"
    query = from fact in Fact,
                 where: ilike(fact.remark, ^fuzzySearchString),
                 or_where: ilike(fact.value, ^fuzzySearchString)

    Repo.all(query)
  end

  @doc """
  Returns the list of fact_types.

  ## Examples

      iex> list_fact_types()
      [%FactType{}, ...]

  """
  def list_fact_types do
    Repo.all(FactType)
  end

  @doc """
  Gets a single fact_type.

  Raises `Ecto.NoResultsError` if the FactType does not exist.

  ## Examples

      iex> get_fact_type!(123)
      %FactType{}

      iex> get_fact_type!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fact_type!(id) do
    Repo.get!(FactType, id)
  end

  @doc """
  Creates a fact_type.

  ## Examples

      iex> create_fact_type(%{field: value})
      {:ok, %FactType{}}

      iex> create_fact_type(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fact_type(attrs \\ %{}) do
    %FactType{}
    |> FactType.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fact_type.

  ## Examples

      iex> update_fact_type(fact_type, %{field: new_value})
      {:ok, %FactType{}}

      iex> update_fact_type(fact_type, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fact_type(%FactType{} = fact_type, attrs) do
    fact_type
    |> FactType.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FactType.

  ## Examples

      iex> delete_fact_type(fact_type)
      {:ok, %FactType{}}

      iex> delete_fact_type(fact_type)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fact_type(%FactType{} = fact_type) do
    Repo.delete(fact_type)
  end

  def search_fact_type(searchString \\ "") do
    fuzzySearchString = "%#{searchString}%"
    query = from fact_type in FactType,
                 where: ilike(fact_type.short_name, ^fuzzySearchString)

    Repo.all(query)
  end
  
end
