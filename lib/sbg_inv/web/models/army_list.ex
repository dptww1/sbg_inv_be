defmodule SbgInv.Web.ArmyList do

  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.{ArmyList, ArmyListSource}

  schema "army_lists" do
    field :name, :string
    field :abbrev, :string
    field :alignment, :integer
    field :legacy, :boolean

    timestamps()

    has_many :sources, ArmyListSource, on_replace: :delete
  end

  def query_by_id(id) do
    from f in ArmyList,
    where: f.id == ^id
  end

  def with_sources(query) do
    from q in query,
    preload: [:sources]
  end
end
