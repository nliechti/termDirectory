defmodule TermDirectoryWeb.TeacherController do
  use TermDirectoryWeb, :controller

  alias TermDirectory.User
  alias TermDirectory.User.Teacher

  action_fallback TermDirectoryWeb.FallbackController

  @doc """
    This catches the search url param and performs a search for
    the given search string in the database
  """
  def index(conn, %{"search" => searchString}) do
    teachers = User.searchTeacher(searchString)
    conn
    |> render("index.json", teachers: teachers)
  end
  
  def index(conn, _params) do
    teachers = User.list_teachers()
    render(conn, "index.json", teachers: teachers)
  end

  def create(conn, teacher_params) do
    with {:ok, %Teacher{} = teacher} <- User.create_teacher(teacher_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", teacher_path(conn, :show, teacher))
      |> render("show.json", teacher: teacher)
    end
  end

  def show(conn, %{"id" => id}) do
    teacher = User.get_teacher!(id)
    render(conn, "show.json", teacher: teacher)
  end

  def update(conn, teacher_params = %{"id" => id}) do
    teacher = User.get_teacher!(id)

    with {:ok, %Teacher{} = teacher} <- User.update_teacher(teacher, teacher_params) do
      render(conn, "show.json", teacher: teacher)
    end
  end

  def delete(conn, %{"id" => id}) do
    teacher = User.get_teacher!(id)
    with {:ok, %Teacher{}} <- User.delete_teacher(teacher) do
      send_resp(conn, :no_content, "")
    end
  end
  
end
