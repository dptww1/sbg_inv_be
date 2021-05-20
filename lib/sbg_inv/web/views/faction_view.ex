defmodule SbgInv.Web.FactionView do

  use SbgInv.Web, :view

  defp filtered_sorted_fig_list(list, type) do
    Enum.filter(list, fn(f) -> f.type == type end)
    |> Enum.sort(&(&1.name <= &2.name))
  end

  defp stringify_id(-1), do: "Totals"
  defp stringify_id(id), do: Atom.to_string(id)

  def render("index.json", %{factions: list}) do
    %{data: Enum.reduce(list,
                        %{},
                        fn(f, acc) ->
                          Map.put(acc,
                                  stringify_id(f.id),
                                  %{
                                    "owned" => f.owned,
                                    "painted" => f.painted
                                   })
                        end)
    }
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
      owned:       if(figure.owned,      do: figure.owned,      else: 0),
      painted:     if(figure.painted,    do: figure.painted,    else: 0)
    }
  end
end
