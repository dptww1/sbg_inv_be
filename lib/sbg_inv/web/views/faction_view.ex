defmodule SbgInv.Web.FactionView do

  use SbgInv.Web, :view

  def filtered_sorted_fig_list(list, type) do
    Enum.filter(list, fn(f) -> f.type == type end)
    |> Enum.sort(&(&1.name <= &2.name))
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

  def render("figure.json", %{faction: figure}) do
    %{
      id:          figure.id,
      name:        figure.name,
      plural_name: figure.plural_name,
      type:        figure.type,
      unique:      figure.unique,
      needed:      if(figure.max_needed, do: figure.max_needed, else: 0),
      owned:       0,
      painted:     0
    }
  end
end
