defmodule TermDirectoryWeb.TeacherView do
  use TermDirectoryWeb, :view
  alias TermDirectoryWeb.TeacherView

  def render("index.json", %{teachers: teachers}) do
    %{data: render_many(teachers, TeacherView, "teacher.json")}
  end

  def render("show.json", %{teacher: teacher}) do
    %{data: render_one(teacher, TeacherView, "teacher.json")}
  end

  def render("teacher.json", %{teacher: teacher}) do
    %{id: teacher.id,
      firstName: teacher.firstName,
      lastName: teacher.lastName}
  end
end
