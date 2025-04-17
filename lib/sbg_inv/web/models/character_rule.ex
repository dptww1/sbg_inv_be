defmodule SbgInv.Web.CharacterRule do
  use SbgInv.Web, :model

  alias SbgInv.Web.{Book, Character}

  schema "character_rules" do
    field :name_override, :string
    field :issue, :string
    field :page, :integer
    field :url, :string
    field :obsolete, :boolean
    field :sort_order, :integer

    timestamps()

    belongs_to :book, Book, source: :book
    belongs_to :character, Character
  end

  @doc false
  def changeset(character_rule, params \\ %{}) do
    character_rule
    |> cast(params, [:name_override, :issue, :page, :url, :obsolete, :sort_order])
    |> put_assoc(:book, Map.get(params, "book"))
  end
end
