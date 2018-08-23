defmodule SbgInv.Web.SearchView do

  use SbgInv.Web, :view

  def render("search.json", %{rows: rows}) do
    %{data: render_many(rows, __MODULE__, "row.json")}
  end

  def render("row.json", %{search: row}) do
    [id, name, type, pos] = row
    %{
      id: id,
      type: type,
      name: name,
      start: pos
    }
  end
end
