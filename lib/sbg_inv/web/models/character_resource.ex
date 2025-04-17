defmodule SbgInv.Web.CharacterResource do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Book, Character}

  schema "character_resources" do
    field :title, :string
    field :issue, :string
    field :page, :integer
    field :type, CharacterResourceType
    field :url, :string

    timestamps()

    belongs_to :book, Book, source: :book
    belongs_to :character, Character
  end

  @doc false
  def changeset(character_resources, params \\ %{}) do
    character_resources
    |> cast(params, [:type, :title, :issue, :url, :page])
    |> put_assoc(:book, Map.get(params, "book"))
    |> validate_required([:type])
  end
end
