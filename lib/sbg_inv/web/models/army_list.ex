defmodule SbgInv.Web.ArmyList do

  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.{ArmyList, ArmyListSource, FactionFigure}

  schema "army_lists" do
    field :name, :string
    field :abbrev, :string
    field :alignment, :integer
    field :legacy, :boolean
    field :keywords, :string

    timestamps()

    has_many :sources, ArmyListSource, on_replace: :delete
    has_many :faction_figures, FactionFigure, foreign_key: :faction_id, on_replace: :delete
  end

  @required_fields [:name, :abbrev, :alignment, :legacy]
  @optional_fields [:keywords]

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> cast_assoc(:sources, required: true)
    |> cast_assoc(:faction_figures, required: true, with: &FactionFigure.changeset_for_army_list/2)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
    |> unique_constraint(:abbrev)
  end

  def query_all() do
    from f in ArmyList,
    order_by: :name
  end

  def query_by_abbrev(abbrev) do
    from f in ArmyList,
    where: f.abbrev == ^abbrev
  end

  def query_by_id(id) do
    from f in ArmyList,
    where: f.id == ^id
  end

  def with_sources(query) do
    from q in query,
    preload: [sources: :book]
  end

  def with_figures(query) do
    from q in query,
    preload: [faction_figures: :figure]
  end
end
