defmodule SbgInv.Web.FactionFigure do

  use SbgInv.Web, :model

  alias SbgInv.Web.Figure

  schema "faction_figures" do
    field :faction_id, Faction

    belongs_to :figure, Figure
  end

  @required_fields [:faction_id, :figure_id]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> cast_assoc(:figure)
  end
end
