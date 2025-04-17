defmodule SbgInv.Web.SearchView do

  use SbgInv.Web, :view

  def render("search.json", %{rows: rows}) do
    %{data: render_many(rows, __MODULE__, "row.json")}
  end

  def render("row.json", %{search: row}) do
    %{
      id: row.id,
      type: row.type,
      name: row.name,
      book: (if is_nil(row.book), do: "", else: row.book),
      plural_name: row.plural_name,
      start: row.pos - 1 # convert Postgres POSITION() return value from 1-based to 0-based
    }
  end
end
