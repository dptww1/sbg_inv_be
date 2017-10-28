defmodule SbgInv.Web.Figure do

  use SbgInv.Web, :model

  alias SbgInv.Web.{FactionFigure, Role, UserFigure, UserFigureHistory}

  schema "figures" do
    field :name, :string
    field :plural_name, :string
    field :type, FigureType
    field :unique, :boolean
    field :max_needed, :integer, virtual: true

    timestamps()

    many_to_many :role, Role, join_through: "role_figures"
    has_many :user_figure, UserFigure
    has_many :faction_figure, FactionFigure
    has_many :user_figure_history, UserFigureHistory
  end

  @required_fields [:name, :type]
  @optional_fields [:plural_name, :unique]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
