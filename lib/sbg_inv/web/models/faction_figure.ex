defmodule SbgInv.Web.FactionFigure do

  use SbgInv.Web, :model

  alias SbgInv.Web.{ArmyList, FactionFigure, Figure, UserFigure}

  schema "faction_figures" do
    belongs_to :army_list, ArmyList, foreign_key: :faction_id
    belongs_to :figure, Figure
  end

  @required_fields_insert [:faction_id, :figure_id]
  @required_fields_for_figure [:faction_id]

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields_insert)
    |> foreign_key_constraint(:faction_id, name: "army_list")
    |> validate_required(@required_fields_insert)
    |> cast_assoc(:figure)
  end

  def changeset_for_figure(model, params \\ %{}) do
    model
    |> cast(params, @required_fields_for_figure)
    |> foreign_key_constraint(:faction_id, name: "army_list")
    |> validate_required(@required_fields_for_figure)
    |> cast_assoc(:figure)
  end

  def query_user_figure_totals(user_id) do
    from uf in UserFigure,
    group_by: uf.user_id,
    having: uf.user_id == ^user_id,
    select: %{
      owned: sum(uf.owned),
      painted: sum(uf.painted)
    }
  end

  def query_collection_figures_by_faction(user_id) do
    from ff in FactionFigure,
    left_join: uf in UserFigure, on: uf.figure_id == ff.figure_id,
    left_join: al in ArmyList, on: al.id == ff.faction_id,
    group_by: [al.abbrev, uf.user_id],
    having: uf.user_id == ^user_id,
    order_by: al.abbrev,
    select: %{
      id: al.abbrev,
      owned: sum(uf.owned),
      painted: sum(uf.painted)
    }
  end

  def query_figures_by_faction_id(user_id, faction_id) do
    from q in faction_query(user_id),
    join: ff in assoc(q, :faction_figure), on: (ff.faction_id == ^faction_id)
  end

  def query_figures_with_no_faction(user_id) do
    from q in faction_query(user_id),
    where: fragment("f0.id NOT IN (SELECT figure_id FROM faction_figures)")
  end

  defp faction_query(user_id) do
    from f in Figure,
    left_join: role in assoc(f, :role),
    left_join: uf in assoc(f, :user_figure), on: (uf.user_id == ^user_id),
    left_join: ch in assoc(f, :characters),
    group_by: [f.id, uf.owned, uf.painted, uf.user_id],
    select: %{
      id: f.id,
      name: f.name,
      plural_name: f.plural_name,
      slug: f.slug,
      type: f.type,
      unique: f.unique,
      max_needed: max(role.amount),
      owned: uf.owned,
      painted: uf.painted,
      user_id: uf.user_id,
      # TODO `max` is not accurate because multiple characters can
      # have non-overlapping resources, so no single character's count
      # is necessarily accurate.  Conversely, `sum` doesn't work because
      # the join with `role` results in duplicate character data.
      # But at least zero/non-zero is useful to the FE
      num_painting_guides: max(ch.num_painting_guides),
      num_analyses: max(ch.num_analyses)
    }
  end
end
