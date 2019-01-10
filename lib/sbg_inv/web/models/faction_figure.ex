defmodule SbgInv.Web.FactionFigure do

  use SbgInv.Web, :model

  alias SbgInv.Web.Figure

  schema "faction_figures" do
    field :faction_id, Faction

    belongs_to :figure, Figure
  end

  @required_fields_insert [:faction_id, :figure_id]
  @required_fields_for_figure [:faction_id]

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields_insert)
    |> validate_required(@required_fields_insert)
    |> cast_assoc(:figure)
  end

  def changeset_for_figure(model, params \\ %{}) do
    model
    |> cast(params, @required_fields_for_figure)
    |> validate_required(@required_fields_for_figure)
    |> cast_assoc(:figure)
  end
end
