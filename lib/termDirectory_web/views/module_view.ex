defmodule TermDirectoryWeb.ModuleView do
  use TermDirectoryWeb, :view
  alias TermDirectoryWeb.ModuleView

  require Logger

  def render("index.json", %{modules: modules}) do
    %{data: render_many(modules, ModuleView, "module.json")}
  end

  def render("show.json", %{module: module}) do
    %{data: render_one(module, ModuleView, "module.json")}
  end

  def render("created.json", %{module: module}) do
    module
    |> inspect
    |> Logger.info
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
    module
    |> inspect
    |> Logger.info
    %{id: module.id,
      subject: module.subject,
      shortName: module.shortName,
      responsible_teacher: %{
        lastName: module.responsible_teacher.lastName,
        firstName: module.responsible_teacher.firstName,
        id: module.responsible_teacher.id
      }
    }
  end
end
