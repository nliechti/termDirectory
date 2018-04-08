defmodule TermDirectoryWeb.FactController do
  use TermDirectoryWeb, :controller

  alias TermDirectory.Modules
  alias TermDirectory.Modules.Fact

  action_fallback TermDirectoryWeb.FallbackController

  @doc """
    This catches the search url param and performs a search for
    the given search string in the database
  """
  def index(conn, %{"search" => searchString}) do
    facts = Modules.search_fact(searchString)
    conn
    |> render("index.json", facts: facts)
  end

  def index(conn, _params) do
    facts = Modules.list_facts()
    render(conn, "index.json", facts: facts)
  end

  def create(conn, fact_params) do
    with {:ok, %Fact{} = fact} <- Modules.create_fact(fact_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", fact_path(conn, :show, fact))
      |> render("show.json", fact: fact)
    end
  end

  def show(conn, %{"id" => id}) do
    fact = Modules.get_fact!(id)
    render(conn, "show.json", fact: fact)
  end

  def update(conn, fact_params = %{"id" => id}) do
    fact = Modules.get_fact!(id)

    with {:ok, %Fact{} = fact} <- Modules.update_fact(fact, fact_params) do
      render(conn, "show.json", fact: fact)
    end
  end

  def delete(conn, %{"id" => id}) do
    fact = Modules.get_fact!(id)
    with {:ok, %Fact{}} <- Modules.delete_fact(fact) do
      send_resp(conn, :no_content, "")
    end
  end

end
