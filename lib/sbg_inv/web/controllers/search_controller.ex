defmodule SbgInv.Web.SearchController do

  use SbgInv.Web, :controller

  def index(conn, %{"q" => q} = params) do
    queries = []
    type = Map.get(params, "type")

    queries =
      if type == nil || type == "f" do
        List.insert_at(queries, -1,
                       "SELECT id, name, plural_name, NULL AS book, 'f' AS type, POSITION(lower($1) IN lower(name)) - 1 AS pos " <>
                       "FROM Figures " <>
                       "WHERE name ILIKE '%' || $1 || '%'")
      else
        queries
      end

    queries =
      if type == nil || type == "s" do
        List.insert_at(queries, -1,
                       "SELECT s.id, s.name, '' AS plural_name, r.book AS book, 's' AS type, POSITION(lower($1) IN lower(name)) - 1 AS pos " <>
                       "FROM Scenarios s " <>
                       "INNER JOIN Scenario_Resources r ON r.scenario_id = s.id " <>
                       "WHERE r.resource_type = 0 " <>
                       "  AND s.name ILIKE '%' || $1 || '%'")
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
