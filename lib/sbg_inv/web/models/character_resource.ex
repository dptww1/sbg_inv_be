defmodule SbgInv.Web.CharacterResource do

  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.{Book, Character, CharacterResource}

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

  def query_recent(limit) do
    from cr in CharacterResource,
         order_by: [desc: cr.inserted_at],
         preload: [:book, :character],
         limit: ^limit
  end
end
