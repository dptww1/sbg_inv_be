defmodule SbgInv.Web.Scenario do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Scenario, ScenarioFaction, ScenarioResource, UserFigure, UserScenario}

  schema "scenarios" do
    field :name,         :string
    field :blurb,        :string
    field :date_age,     :integer
    field :date_year,    :integer
    field :date_month,   :integer
    field :date_day,     :integer
    field :size,         :integer
    field :map_width,    :integer
    field :map_height,   :integer
    field :location,     Location
    field :rating,       :float
    field :num_votes,    :integer

    timestamps()

    has_many :scenario_resources, ScenarioResource
    has_many :scenario_factions, ScenarioFaction, on_replace: :delete
    has_many :user_scenarios, UserScenario
  end

  @required_fields [:name, :blurb, :date_age, :date_year, :date_month, :date_day, :size, :map_width, :map_height, :location]
  @optional_fields [:rating, :num_votes]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> base_changeset(params)
    |> cast_assoc(:scenario_factions,
                  Map.get(params, "scenario_factions", [])
                  |> Enum.map(fn (sf_params) -> ScenarioFaction.changeset(%ScenarioFaction{}, sf_params) end))
  end

  def base_changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def ratings_breakdown_query(id) do
    from us in UserScenario,
    group_by: us.rating,
    where: us.scenario_id == ^id,
    having: us.rating > 0,
    select: [
      us.rating,
      count(us.rating)
    ]
  end

  def query_all() do
    from s in Scenario,
    order_by: [asc: :date_age, asc: :date_year, asc: :date_month, asc: :date_day]
  end

  def query_by_id(id) do
    from s in Scenario,
    where: s.id == ^id
  end

  def with_factions(query) do
    from q in query,
    preload: [:scenario_factions]
  end

  def with_figures(query, user_id) do
    ufq = from uf in UserFigure, where: uf.user_id == ^user_id

    from q in query,
    preload: [scenario_factions: [roles: [figures: [user_figure: ^ufq]]]]
  end

  def with_roles(query) do
    from q in query,
    preload: [scenario_factions: :roles]
  end

  def with_resources(query) do
    sr = from sr in ScenarioResource, order_by: :sort_order

    from q in query,
    preload: [scenario_resources: ^{sr, :book}]
  end

  def with_user(query, user_id) do
    uq = from us in UserScenario, where: us.user_id == ^user_id

    from q in query,
    preload: [user_scenarios: ^uq]
  end
end
