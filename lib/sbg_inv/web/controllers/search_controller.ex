defmodule SbgInv.Web.SearchController do

  use SbgInv.Web, :controller

  def index(conn, %{"q" => q} = params) do
    queries = []
    type = Map.get(params, "type")

    queries =
      if type == nil || type == "f" do
        List.insert_at(queries, -1,
                       "SELECT id, name, 'f' AS type, POSITION($1 IN name) - 1 AS pos " <>
                       "FROM Figures " <>
                       "WHERE name ILIKE '%' || $1 || '%'")
      else
        queries
      end

    queries =
      if type == nil || type == "s" do
        List.insert_at(queries, -1,
                       "SELECT id, name, 's' AS type, POSITION($1 IN name) - 1 AS pos " <>
                       "FROM Scenarios " <>
                       "WHERE name ILIKE '%' || $1 || '%'")
      else
        queries
      end

    results = Repo.query("SELECT * FROM (" <>
                         Enum.join(queries, " UNION ") <>
                         ") AS results " <>
                         "ORDER BY pos, name, id", [q])

    with {:ok, %{ rows: rows }} <- results
    do
      render(conn, "search.json", %{rows: rows})
    else
      _ -> send_resp(conn, :no_content, "")
    end
  end
end
