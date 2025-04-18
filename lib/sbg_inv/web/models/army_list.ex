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
end
