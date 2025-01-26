defmodule SbgInv.Web.ScenarioFaction do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Role, Scenario, ScenarioFaction}

  schema "scenario_factions" do
    field :suggested_points, :integer
    field :actual_points, :integer
    field :sort_order, :integer

    timestamps()

    belongs_to :scenario, Scenario
    has_many :roles, Role, on_replace: :delete
  end

  @required_fields [:suggested_points, :actual_points, :sort_order]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> cast_assoc(:roles, Map.get(params, "roles", []))
    |> validate_required(@required_fields)
  end

  def query_by_id(id) do
    from sf in ScenarioFaction,
    where: sf.id == ^id
  end

  def with_figures(query) do
    from q in query,
    preload: [roles: :figures]
  end

  def with_roles(query) do
    from q in query,
    preload: [scenario_factions: :roles]
  end
end
