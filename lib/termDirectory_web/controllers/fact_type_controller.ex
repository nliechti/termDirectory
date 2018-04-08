defmodule TermDirectoryWeb.FactTypeController do
  @moduledoc false

  use TermDirectoryWeb, :controller

  alias TermDirectory.Modules
  alias TermDirectory.Modules.FactType

  action_fallback TermDirectoryWeb.FallbackController

  @doc """
    This catches the search url param and performs a search for
    the given search string in the database
  """
  def index(conn, %{"search" => searchString}) do
    fact_types = Modules.search_fact_type(searchString)
    conn
    |> render("index.json", fact_types: fact_types)
  end

  def index(conn, _params) do
    fact_types = Modules.list_fact_types()
    render(conn, "index.json", fact_types: fact_types)
  end

  def create(conn, fact_type_params) do
    with {:ok, %FactType{} = fact_type} <- Modules.create_fact_type(fact_type_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", fact_type_path(conn, :show, fact_type))
      |> render("show.json", fact_type: fact_type)
    end
  end

  def show(conn, %{"id" => id}) do
    fact_type = Modules.get_fact_type!(id)
    render(conn, "show.json", fact_type: fact_type)
  end

  def update(conn, fact_type_params = %{"id" => id}) do
    fact_type = Modules.get_fact_type!(id)

    with {:ok, %FactType{} = fact_type} <- Modules.update_fact_type(fact_type, fact_type_params) do
      render(conn, "show.json", fact_type: fact_type)
    end
  end

  def delete(conn, %{"id" => id}) do
    fact_type = Modules.get_fact_type!(id)
    with {:ok, %FactType{}} <- Modules.delete_fact_type(fact_type) do
      send_resp(conn, :no_content, "")
    end
  end
end
