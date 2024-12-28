defmodule SbgInv.Web.Character do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Character, CharacterResource, CharacterRule, Figure}

  schema "characters" do
    field :name, :string
    field :faction, Faction
    field :num_painting_guides, :integer
    field :num_analyses, :integer

    timestamps()

    has_many :rules, CharacterRule, on_replace: :delete
    has_many :resources, CharacterResource, on_replace: :delete
    many_to_many :figures, Figure,
             join_through: "character_figures",
             on_replace: :delete
  end

  @doc false
  def changeset(character, params \\ %{}) do
    figures =
      Map.get(params, "figure_ids", [])
      |> load_figures

    changeset =
      character
      |> cast(params, [:name, :faction])
      |> cast_assoc(:resources)
      |> cast_assoc(:rules)
      |> put_assoc(:figures, figures)
      |> validate_required([:name])

    if changeset.valid? do
      changeset
      |> put_change(:num_painting_guides, resource_count(params["resources"], "painting_guide"))
      |> put_change(:num_analyses, resource_count(params["resources"], "analysis"))
    end
  end

  def query_by_id(id) do
    from c in Character,
    where: c.id == ^id
  end

  def with_figures(query) do
    fq = from f in Figure, order_by: f.name

    from q in query,
    preload: [figures: ^fq]
  end

  def with_resources(query) do
    rq = from cr in CharacterResource, order_by: cr.title

    from q in query,
    preload: [resources: ^rq]
  end

  def with_rules(query) do
    rq = from cr in CharacterRule, order_by: cr.sort_order

    from q in query,
    preload: [rules: ^rq]
  end

  defp load_figures([]), do: []
  defp load_figures(figure_ids) do
    SbgInv.Repo.all(
      from f in Figure,
      where: f.id in ^figure_ids,
      order_by: f.name)
  end

  defp resource_count(array, type) when is_list(array) do
    Enum.count(array, fn r -> r["type"] == type end)
  end
  defp resource_count(_, _), do: 0
end
