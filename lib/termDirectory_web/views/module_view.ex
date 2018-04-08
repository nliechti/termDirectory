defmodule TermDirectoryWeb.ModuleView do
  use TermDirectoryWeb, :view
  alias TermDirectoryWeb.ModuleView
  alias TermDirectoryWeb.TeacherView
  alias TermDirectoryWeb.FactView

  require Logger

  def render("all_modules_simple.json", %{modules: modules}) do
    %{data: render_many(modules, ModuleView, "simple_module.json")}
  end

  def render("one_simple_module.json", %{module: module}) do
    %{data: render_one(module, ModuleView, "simple_module.json")}
  end

  def render("simple_module.json", %{module: module}) do
    module |> inspect |> Logger.info
    %{
      id: module.id,
      subject: module.subject,
      shortName: module.shortName,
      responsible_teacher_id: module.responsible_teacher_id
    }
  end
  
  def render("one_extended_module.json",  %{module: module}) do
    %{data: render_one(module, ModuleView, "module.json")}
  end

  def render("module.json", %{module: module}) do
    module |> inspect |> Logger.info
    %{id: module.id,
      subject: module.subject,
      shortName: module.shortName,
      responsible_teacher: render_one(module.responsible_teacher, TeacherView, "teacher.json"),
      module_workers: render_many(module.module_workers, TeacherView, "teacher.json"),
      facts: render_many(module.facts, FactView, "fact.json")
    }
  end
end
