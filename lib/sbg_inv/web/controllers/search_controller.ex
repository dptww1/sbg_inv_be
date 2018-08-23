defmodule SbgInv.Web.SearchController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Figure, Scenario}

  def index(conn, %{"q" => q}) do
    results = Repo.query("""
      SELECT * FROM (
        SELECT id, name, 'f' AS type, POSITION($1 IN name) - 1 AS pos FROM Figures WHERE name ILIKE '%' || $1 || '%'
      UNION
        SELECT id, name, 's' AS type, POSITION($1 IN name) - 1 AS pos FROM Scenarios WHERE name ILIKE '%' || $1 || '%'
      ) AS results
      ORDER BY name, id
      """,  [q]
    )

    with {:ok, %{ rows: rows }} <- results
    do
      render(conn, "search.json", %{rows: rows})
    else
      _ -> send_resp(conn, :no_content, "")
    end
  end
end
