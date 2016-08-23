defmodule SbgInv.ScenarioFaction do
  use SbgInv.Web, :model

  schema "scenario_factions" do
    field :faction, Faction
    field :suggested_points, :integer
    field :actual_points, :integer
    field :sort_order, :integer

    timestamps

    belongs_to :scenario, SbgInv.Scenario
    has_many :scenario_faction_figures, SbgInv.ScenarioFactionFigure
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
