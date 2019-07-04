defmodule SbgInv.Web.SearchView do

  use SbgInv.Web, :view

  def render("search.json", %{rows: rows}) do
    %{data: render_many(rows, __MODULE__, "row.json")}
  end

  def render("row.json", %{search: row}) do

    [id, name, plural_name, book, type, pos] = row
    %{
      id: id,
      type: type,
      name: name,
      book: if(book, do: elem(ScenarioResourceBook.load(book), 1), else: ""),
      plural_name: plural_name,
      start: pos
    }
  end
end
