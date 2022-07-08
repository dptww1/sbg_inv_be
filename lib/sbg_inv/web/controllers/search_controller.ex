defmodule SbgInv.Web.SearchController do

  use SbgInv.Web, :controller

  alias SbgInv.Web.Search

  def index(conn, %{"q" => q} = params) do
    type = Map.get(params, "type")

    search_query =
      scenario_query(type, q)
      |> unionize(figure_query(type, q))
      |> unionize(character_query(type, q))

    results =
      Repo.all(search_query)
      |> Enum.map(fn res -> add_substring_match_position(res, q) end)
      |> Enum.sort(&sort_by_pos_then_name/2)

    render(conn, "search.json", %{rows: results})
  end

  # character_query not used when type == nil
  defp character_query("c", q), do: Search.character_search(q)
  defp character_query(_, _), do: nil

  defp figure_query(nil, q), do: Search.figure_search(q)
  defp figure_query("f", q), do: Search.figure_search(q)
  defp figure_query(_, _), do: nil

  defp scenario_query(nil, q), do: Search.scenario_search(q)
  defp scenario_query("s", q), do: Search.scenario_search(q)
  defp scenario_query(_, _),  do: nil

  defp unionize(nil, q2), do: q2
  defp unionize(q1, nil), do: q1
  defp unionize(q1, q2), do: from q1, union: ^q2

  defp add_substring_match_position(row, q) do
    Map.put(row, :pos,
      # Apparently String.split is the best way to find the location within a string of a substring /shrug
      String.split(row.name, ~r/#{q}/i, parts: 2)
      |> Enum.at(0)
      |> String.length
    )
  end

  defp sort_by_pos_then_name(a, b) when a.pos < b.pos, do: true
  defp sort_by_pos_then_name(a, b) when a.pos > b.pos, do: false
  defp sort_by_pos_then_name(a, b) when a.name <= b.name, do: true
  defp sort_by_pos_then_name(_, _), do: false
end
