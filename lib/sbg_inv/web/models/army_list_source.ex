defmodule SbgInv.Web.ArmyListSource do

  use SbgInv.Web, :model

  alias SbgInv.Web.{ArmyList, Book}

  schema "army_lists_sources" do
    field :issue, :string
    field :page, :integer
    field :url, :string
    field :sort_order, :integer

    timestamps()

    belongs_to :book, Book, source: :book
    belongs_to :army_list, ArmyList

    @optional_params [:issue, :page, :url, :sort_order]
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @optional_params)
    |> put_assoc(:book, Map.get(params, "book"))
  end
end
