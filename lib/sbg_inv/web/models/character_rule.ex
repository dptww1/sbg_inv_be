defmodule SbgInv.Web.CharacterRule do
  use SbgInv.Web, :model

  alias SbgInv.Web.Character

  schema "character_rules" do
    field :name_override, :string
    field :book, ScenarioResourceBook
    field :issue, :string
    field :page, :integer
    field :url, :string
    field :obsolete, :boolean
    field :sort_order, :integer

    timestamps()

    belongs_to :character, Character
  end

  @doc false
  def changeset(character_rules, params \\ %{}) do
    character_rules
    |> cast(params, [:name_override, :book, :issue, :page, :url, :obsolete, :sort_order])
  end
end
