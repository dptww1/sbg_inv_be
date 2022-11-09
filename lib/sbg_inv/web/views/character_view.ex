defmodule SbgInv.Web.CharacterView do

  use SbgInv.Web, :view

  def render("character.json", %{character: char}) do
    %{data: %{
      "id" => char.id,
      "name" => char.name,
      "faction" => char.faction,
      "book" => char.book,
      "page" => char.page,
      "figures" => figure_list(char.figures),
      "resources" => resource_list(char.resources),
      "num_painting_guides" => zeroize_nil(char.num_painting_guides),
      "num_analyses" => zeroize_nil(char.num_analyses)
    }}
  end

  defp figure_list([]), do: []
  defp figure_list(figures) do
    Enum.map(figures, fn f ->
      %{
        "id" => f.id,
        "name" => f.name
      }
    end)
  end

  defp resource_list([]), do: []
  defp resource_list(resources) do
    Enum.map(resources, fn r ->
      put_if_non_nil(%{}, "title", r.title)
      |> put_if_non_nil("book", r.book)
      |> put_if_non_nil("issue", r.issue)
      |> put_if_non_nil("page", r.page)
      |> put_if_non_nil("type", r.type)
      |> put_if_non_nil("url", r.url)
    end)
  end

  defp put_if_non_nil(map, _, nil), do: map
  defp put_if_non_nil(map, key, val), do: Map.put(map, key, val)

  defp zeroize_nil(nil), do: 0
  defp zeroize_nil(x), do: x
end
