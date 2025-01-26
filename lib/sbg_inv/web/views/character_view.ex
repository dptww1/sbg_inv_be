defmodule SbgInv.Web.CharacterView do

  use SbgInv.Web, :view

  def render("character.json", %{character: char}) do
    %{data: %{
      "id" => char.id,
      "name" => char.name,
      "figures" => figure_list(char.figures),
      "resources" => render_many(char.resources, SbgInv.Web.CharacterResourceView, "resource.json", as: :resource),
      "rules" => render_many(char.rules, SbgInv.Web.CharacterRuleView, "rule.json", as: :rule),
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

  defp zeroize_nil(nil), do: 0
  defp zeroize_nil(x), do: x
end
