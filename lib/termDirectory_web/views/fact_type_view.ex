defmodule TermDirectoryWeb.FactTypeView do
  @moduledoc false

  use TermDirectoryWeb, :view
  alias TermDirectoryWeb.FactTypeView

  def render("index.json", %{fact_types: fact_types}) do
    %{data: render_many(fact_types, FactTypeView, "fact_type.json")}
  end

  def render("show.json", %{fact_type: fact_type}) do
    %{data: render_one(fact_type, FactTypeView, "fact_type.json")}
  end

  def render("fact_type.json", %{fact_type: fact_type}) do
    %{
      id: fact_type.id,
      firstName: fact_type.short_name,
    }
  end
end
