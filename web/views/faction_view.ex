defmodule SbgInv.FactionView do
  use SbgInv.Web, :view

  def filtered_sorted_fig_list(list, type) do
    Enum.filter(list, fn(ff) -> ff.figure.type == type end)
    |> Enum.sort(&(&1.figure.name <= &2.figure.name))
  end

  def render("show.json", %{figures: figures}) do
    %{data: %{
         "heroes"   => render_many(filtered_sorted_fig_list(figures, :hero    ), __MODULE__, "figure.json"),
         "warriors" => render_many(filtered_sorted_fig_list(figures, :warrior ), __MODULE__, "figure.json"),
         "monsters" => render_many(filtered_sorted_fig_list(figures, :monster ), __MODULE__, "figure.json"),
         "siegers"  => render_many(filtered_sorted_fig_list(figures, :sieger  ), __MODULE__, "figure.json"),
        }
     }
  end

  def render("figure.json", %{faction: faction_figure}) do
    %{
      id:          faction_figure.figure.id,
      name:        faction_figure.figure.name,
      plural_name: faction_figure.figure.plural_name,
      type:        faction_figure.figure.type,
      unique:      faction_figure.figure.unique
    }
  end
end
