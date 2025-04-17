defmodule SbgInv.Web.BookUtils do

  alias SbgInv.Repo
  alias SbgInv.Web.Book

  def add_book_refs(nil), do: []
  def add_book_refs(list) do
    Enum.map(list, &add_book_ref/1)
  end

  def add_book_ref(map) do
    key = Map.get(map, "book")
    add_book_ref_maybe(map, key)
  end

  defp add_book_ref_maybe(map, nil), do: map
  defp add_book_ref_maybe(map, key) do
    Map.put(map, "book",
            key
            |> Book.query_by_key
            |> Repo.one!)
  end
end
