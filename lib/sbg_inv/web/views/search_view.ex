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
      book: book_str(row.book),
      plural_name: row.plural_name,
      start: row.pos
    }
  end

  defp book_str(nil), do: ""
  defp book_str(s) do
    s |> Atom.to_string
  end
end
