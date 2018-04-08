defmodule TermDirectoryWeb.ModuleController do
  use TermDirectoryWeb, :controller

  alias TermDirectory.Modules
  alias TermDirectory.Modules.Module

  action_fallback TermDirectoryWeb.FallbackController

  @doc """
    This catches the search url param and performs a search for
    the given search string in the database
  """
  def index(conn, %{"search" => searchString}) do
    modules = Modules.searchModule(searchString)
    conn
    |> render("all_modules_simple.json", modules: modules)
  end
  
  def index(conn, _params) do
    modules = Modules.list_modules()
    render(conn, "all_modules_simple.json", modules: modules)
  end

  def create(conn, module_params) do
    with {:ok, %Module{} = module} <- Modules.create_module(module_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", module_path(conn, :show, module))
      |> render("one_simple_module.json", module: module)
    end
  end

  def show(conn, %{"id" => id}) do
    module = Modules.get_module!(id)
    render(conn, "one_extended_module.json", module: module)
  end

  def update(conn, module_params = %{"id" => id}) do
    module = Modules.get_module!(id)

    with {:ok, %Module{} = module} <- Modules.update_module(module, module_params) do
      render(conn, "one_simple_module.json", module: module)
    end
  end

  def delete(conn, %{"id" => id}) do
    module = Modules.get_module!(id)
    with {:ok, %Module{}} <- Modules.delete_module(module) do
      send_resp(conn, :no_content, "")
    end
  end
end
