defmodule SbgInv.Web.CharacterResource do

  use SbgInv.Web, :model

  alias SbgInv.Web.Character

  schema "character_resources" do
    field :book, ScenarioResourceBook
    field :display_name, :string
    field :page, :integer
    field :type, :integer
    field :url, :string

    timestamps()

    belongs_to :character, Character
  end

  @doc false
  def changeset(character_resources, attrs) do
    character_resources
    |> cast(attrs, [:type, :display_name, :url, :book, :page])
    |> validate_required([:type, :display_name])
  end
end
