defmodule SbgInv.Web.Search do
  @moduledoc """
  Not really a model, just a container for search SQL (at least for the moment).
  """

  use SbgInv.Web, :model

  alias SbgInv.Web.{Character, Figure, Scenario}

  def character_search(query_str) do
    wildcarded_query_str = "%" <> query_str <> "%"

    from c in Character,
    select: %{
      id: c.id,
      name: c.name,
      plural_name: "",
      book: nil,
      type: "c",
      pos: fragment("POSITION(LOWER(f_unaccent(?)) IN LOWER(f_unaccent(?)))", ^query_str, c.name)
    },
    where: fragment("f_unaccent(?) ILIKE f_unaccent(?)", c.name, ^wildcarded_query_str)
  end

  def figure_search(query_str) do
    wildcarded_query_str = "%" <> query_str <> "%"

    from f in Figure,
    select: %{
      id: f.id,
      name: f.name,
      plural_name: f.plural_name,
      book: nil,
      type: "f",
      pos: fragment("POSITION(LOWER(f_unaccent(?)) IN LOWER(f_unaccent(?)))", ^query_str, f.name)
    },
    where: fragment("f_unaccent(?) ILIKE f_unaccent(?)", f.name, ^wildcarded_query_str)
  end

  def scenario_search(query_str) do
    wildcarded_query_str = "%" <> query_str <> "%"

    from s in Scenario,
    join: res in assoc(s, :scenario_resources), on: (res.scenario_id == s.id),
    select: %{
      id: s.id,
      name: s.name,
      plural_name: "",
      book: res.book,
      type: "s",
      pos: fragment("POSITION(LOWER(f_unaccent(?)) IN LOWER(f_unaccent(?)))", ^query_str, s.name)
    },
    where: fragment("f_unaccent(?) ILIKE f_unaccent(?)", s.name, ^wildcarded_query_str),
    where: res.resource_type == :source
    #ilike(s.name, ^wildcarded_query_str) and res.resource_type == :source
  end
end
