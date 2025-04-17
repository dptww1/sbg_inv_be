defmodule SbgInv.Web.Book do

  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.{Book, CharacterResource, CharacterRule, ScenarioResource}

  schema "books" do
    field :key, :string
    field :short_name, :string
    field :year, :string
    field :name, :string

    timestamps()

    has_many :character_resources, CharacterResource
    has_many :character_rules, CharacterRule
    has_many :scenario_resources, ScenarioResource
  end


  def query_all() do
    from f in Book,
    order_by: :name
  end

  def query_by_key(key) do
    from b in Book,
    where: b.key == ^key
  end
end
