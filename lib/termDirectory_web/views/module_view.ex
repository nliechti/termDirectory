defmodule TermDirectoryWeb.ModuleView do
  use TermDirectoryWeb, :view
  alias TermDirectoryWeb.ModuleView

  def render("index.json", %{modules: modules}) do
    %{data: render_many(modules, ModuleView, "module.json")}
  end

  def render("show.json", %{module: module}) do
    %{data: render_one(module, ModuleView, "module.json")}
  end

  def render("module.json", %{module: module}) do
    %{id: module.id,
      subject: module.subject,
      shortName: module.shortName,
      responsible_teacher_id: module.responsible_teacher_id}
  end
end
