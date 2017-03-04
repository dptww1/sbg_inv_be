defmodule SbgInv.Web.FactionFigure do

  use SbgInv.Web, :model

  alias SbgInv.Web.Figure

  schema "faction_figures" do
    field :faction_id, Faction

    belongs_to :figure, Figure
  end

  @required_fields ~w(faction_id figure_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> cast_assoc(:figures, params)
  end
end
