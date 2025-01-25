defmodule SbgInv.Web.FactionView do

  use SbgInv.Web, :view

  def render("show.json", %{figures: figures, army_list: army_list}) do
    %{
    data:
      figures_map(figures)
      |> Map.put("sources", render_many(army_list.sources, __MODULE__, "source.json", as: :source))
    }
  end

  def render("show.json", %{figures: figures}) do
    %{
      data: figures_map(figures)
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

  def render("bare_index.json", %{factions: list}) do
    %{
      data: %{
        factions: render_many(list, __MODULE__, "bare_index_entry.json")
      }
    }
  end

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

  def render("source.json", %{source: source}) do
    %{
      book: source.book,
      issue: source.issue,
      page: source.page,
      url: source.url
    }
  end

  def render("bare_index_entry.json", %{faction: faction}) do
    %{
      id: faction.id,
      name: faction.name,
      abbrev: faction.abbrev,
      alignment: faction.alignment,
      legacy: !!faction.legacy, # normalize from true/nil to true/false
      keywords: faction.keywords
    }
  end

  defp figures_map(figures) do
    %{
      "heroes"   => render_many(filtered_sorted_fig_list(figures, :hero    ), __MODULE__, "figure.json"),
      "warriors" => render_many(filtered_sorted_fig_list(figures, :warrior ), __MODULE__, "figure.json"),
      "monsters" => render_many(filtered_sorted_fig_list(figures, :monster ), __MODULE__, "figure.json"),
      "siegers"  => render_many(filtered_sorted_fig_list(figures, :sieger  ), __MODULE__, "figure.json")
    }
  end

  defp filtered_sorted_fig_list(list, type) do
    list
    |> Enum.filter(&(&1.type == type))
    |> Enum.sort(&(&1.name <= &2.name))
  end

  defp stringify_id(-1), do: "Totals"
  defp stringify_id(id), do: id

  defp normalize_int(nil), do: 0
  defp normalize_int(x), do: x
end
