defmodule SbgInv.Figure do
  use SbgInv.Web, :model

  schema "figures" do
    field :name, :string
    field :plural_name, :string

    timestamps

    has_many :scenario_faction_figure, SbgInv.ScenarioFactionFigure
    has_many :user_figure, SbgInv.UserFigure
  end

  @required_fields ~w(name)
  @optional_fields ~w(plural_name)

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
