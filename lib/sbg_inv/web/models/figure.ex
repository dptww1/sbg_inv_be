defmodule SbgInv.Web.Figure do

  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.{Character, FactionFigure, Figure, Role, UserFigure, UserFigureHistory}

  schema "figures" do
    field :name, :string
    field :plural_name, :string
    field :type, FigureType
    field :unique, :boolean
    field :slug, :string
    field :max_needed, :integer, virtual: true

    timestamps()

    many_to_many :role, Role, join_through: "role_figures"
    has_many :user_figure, UserFigure
    has_many :faction_figure, FactionFigure, on_replace: :delete
    has_many :user_figure_history, UserFigureHistory
    many_to_many :characters, Character,
                 join_through: "character_figures"
  end

  @required_fields [:name, :type]
  @optional_fields [:plural_name, :unique, :slug]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> put_assoc(:faction_figure, Map.get(params, "faction_figure", []))
    |> validate_required(@required_fields)
  end

  @doc """
  Create specialized changeset for testing purposes.  Since the public API
  only supports editing the Character<->Figure relationship from the Character
  side, client code should ordinarily use `Figure.changeset/2`.
  """
  def changeset_with_characters(model, params \\ %{}) do
    characters =
      (Map.get(params, "character_ids", []) # controllers use strings
       |> load_characters)
      ++
      (Map.get(params, :character_ids, []) # models & tests use symbols
       |> load_characters)

    put_assoc(changeset(model, params), :characters, characters)
  end

  def query_by_id(figure_id) do
    from f in Figure,
    where: f.id == ^figure_id
  end

  def query_stats(figure_id) do
    from uf in UserFigure,
    where: uf.figure_id == ^figure_id,
    group_by: uf.figure_id,
    select: %{
      total_owned: sum(uf.owned),
      total_painted: sum(uf.painted)
    }
  end

  def with_characters_and_resources_and_rules(query) do
    ch_query = from ch in Character, order_by: :name

    from q in query,
    preload: [characters: ^ch_query],
    preload: [characters: [[resources: :book], [rules: :book]]]
  end

  def with_factions(query) do
    ff_query =
      from ff in FactionFigure,
           preload: :army_list,
           order_by: :faction_id

    from q in query,
    preload: [faction_figure: ^ff_query]
  end

  def with_scenarios(query) do
    from q in query,
    preload: [role: [scenario_faction: [scenario: [scenario_resources: :book]]]]
  end

  def with_user(query, user_id) do
    uf_query = from uf in UserFigure, where: uf.user_id == ^user_id

    from q in query,
    preload: [user_figure: ^uf_query]
  end

  def with_user_history(query, user_id) do
    ufh_query =
      from ufh in UserFigureHistory,
      where: ufh.user_id == ^user_id,
      order_by: [asc: ufh.op_date, desc: ufh.updated_at]

    from q in query,
    preload: [user_figure_history: ^ufh_query]
  end

  defp load_characters([]), do: []
  defp load_characters(character_ids) do
    SbgInv.Repo.all(
      from ch in Character,
      where: ch.id in ^character_ids,
      order_by: ch.name)
  end
end
