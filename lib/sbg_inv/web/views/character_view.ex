defmodule SbgInv.Web.CharacterView do

  use SbgInv.Web, :view

  def render("character.json", %{character: char}) do
    %{data: %{
      "id" => char.id,
      "name" => char.name,
      "book" => char.book,
      "page" => char.page,
      "figures" => figure_list(char.figures)
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
end
