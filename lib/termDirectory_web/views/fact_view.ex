defmodule TermDirectoryWeb.FactView do
  @moduledoc false

  use TermDirectoryWeb, :view
  alias TermDirectoryWeb.FactView

  def render("index.json", %{facts: facts}) do
    %{data: render_many(facts, FactView, "fact.json")}
  end

  def render("show.json", %{fact: fact}) do
    %{data: render_one(fact, FactView, "fact.json")}
  end

  def render("fact.json", %{fact: fact}) do
    %{
      id: fact.id,
      firstName: fact.value,
      lastName: fact.remark
    }
  end
end
