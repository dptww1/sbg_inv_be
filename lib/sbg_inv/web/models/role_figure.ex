defmodule SbgInv.Web.RoleFigure do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Figure, Role}

  schema "role_figures" do
    belongs_to :role, Role
    belongs_to :figure, Figure
  end

  @required_fields ~w(role_id figure_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
