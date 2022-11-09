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
      id:                  figure.id,
      name:                figure.name,
      plural_name:         figure.plural_name,
      slug:                figure.slug,
      type:                figure.type,
      unique:              figure.unique,
      needed:              normalize_int(figure.max_needed),
      owned:               normalize_int(figure.owned),
      painted:             normalize_int(figure.painted),
      num_painting_guides: normalize_int(figure.num_painting_guides),
      num_analyses:        normalize_int(figure.num_analyses)
    }
  end

  defp normalize_int(nil), do: 0
  defp normalize_int(x), do: x
end
