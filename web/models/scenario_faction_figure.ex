defmodule SbgInv.ScenarioFactionFigure do
  use SbgInv.Web, :model

  schema "scenario_faction_figures" do
    field :amount, :integer
    field :sort_order, :integer

    belongs_to :figure, SbgInv.Figure
    belongs_to :scenario_faction, SbgInv.ScenarioFaction

    timestamps
  end

  @required_fields ~w(amount sort_order figure_id scenario_faction_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
