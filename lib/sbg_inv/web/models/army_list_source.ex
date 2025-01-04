defmodule SbgInv.Web.ArmyListSource do

  use SbgInv.Web, :model

  alias SbgInv.Web.{ArmyList}

  schema "army_lists_sources" do
    field :book, ScenarioResourceBook
    field :issue, :string
    field :page, :integer
    field :url, :string
    field :sort_order, :integer

    timestamps()

    belongs_to :army_list, ArmyList
  end
end
