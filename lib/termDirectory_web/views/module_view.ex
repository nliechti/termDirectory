defmodule TermDirectoryWeb.ModuleView do
  use TermDirectoryWeb, :view
  alias TermDirectoryWeb.ModuleView
  alias TermDirectoryWeb.TeacherView

  require Logger

  def render("index.json", %{modules: modules}) do
    %{data: render_many(modules, ModuleView, "module.json")}
  end

  def render("show.json", %{module: module}) do
    %{data: render_one(module, ModuleView, "module.json")}
  end

  def render("created.json", %{module: module}) do
    %{
      data: %{
        id: module.id,
        subject: module.subject,
        shortName: module.shortName,
        responsible_teacher_id: module.responsible_teacher_id
      }
    }
  end

  def render("module.json", %{module: module}) do
    module |> inspect |> Logger.info
    %{id: module.id,
      subject: module.subject,
      shortName: module.shortName,
      responsible_teacher: render_one(module.responsible_teacher, TeacherView, "teacher.json"),
      module_workers: render_many(module.module_workers, TeacherView, "teacher.json")
    }
  end
end
