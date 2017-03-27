defmodule SbgInv.Web.ScenarioFaction do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Role, Scenario}

  schema "scenario_factions" do
    field :faction, Faction
    field :suggested_points, :integer
    field :actual_points, :integer
    field :sort_order, :integer

    timestamps

    belongs_to :scenario, Scenario
    has_many :roles, Role
  end

  @required_fields ~w(scenario_id faction suggested_points actual_points sort_order)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end