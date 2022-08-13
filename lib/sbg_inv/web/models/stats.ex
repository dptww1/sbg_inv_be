defmodule SbgInv.Web.Stats do
  @moduledoc """
  Non-persistent model providing queries for `SbgInv.Web.StatsController`.
  """

  import Ecto.Query

  alias SbgInv.Web.Figure

  def query_most_collected_character do
    from q in most_collected_query(),
    or_having: q.type == :hero and q.unique == true
  end

  def query_most_collected_hero do
    from q in most_collected_query(),
    or_having: q.type == :hero and not q.unique
  end

  def query_most_collected_monster do
    from q in most_collected_query(),
    or_having: q.type == :monster
  end

  def query_most_collected_warrior do
    from q in most_collected_query(),
    or_having: q.type == :warrior
  end

  def query_most_painted_character do
    from q in most_painted_query(),
    or_having: q.type == :hero and q.unique == true
  end

  def query_most_painted_hero do
    from q in most_painted_query(),
    or_having: q.type == :hero and not q.unique
  end

  def query_most_painted_monster do
    from q in most_painted_query(),
    or_having: q.type == :monster
  end

  def query_most_painted_warrior do
    from q in most_painted_query(),
    or_having: q.type == :warrior
  end

  defp most_painted_query do
    from f in Figure,
    join: uf in assoc(f, :user_figure),
    group_by: [uf.figure_id, f.name, f.slug, f.type, f.unique],
    order_by: [desc: sum(uf.painted)],
    select: %{
      id: uf.figure_id,
      name: f.name,
      slug: f.slug,
      total: sum(uf.painted)
    },
    limit: 5
  end

  defp most_collected_query do
    from f in Figure,
    join: uf in assoc(f, :user_figure),
    group_by: [uf.figure_id, f.name, f.slug, f.type, f.unique],
    order_by: [desc: sum(uf.owned)],
    select: %{
      id: uf.figure_id,
      name: f.name,
      slug: f.slug,
      total: sum(uf.owned)
    },
    limit: 5
  end
end
