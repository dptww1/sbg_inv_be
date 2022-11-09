defmodule SbgInv.Web.CharacterResource do

  use SbgInv.Web, :model

  alias SbgInv.Web.Character

  schema "character_resources" do
    field :title, :string
    field :book, ScenarioResourceBook
    field :issue, :string
    field :page, :integer
    field :type, CharacterResourceType
    field :url, :string

    timestamps()

    belongs_to :character, Character
  end

  @doc false
  def changeset(character_resources, params \\ %{}) do
    character_resources
    |> cast(params, [:type, :title, :issue, :url, :book, :page])
    |> validate_required([:type, :title])
  end
end
