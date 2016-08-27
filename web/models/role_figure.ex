defmodule SbgInv.RoleFigure do
  use SbgInv.Web, :model

  schema "role_figures" do
    belongs_to :role, SbgInv.Role
    belongs_to :figure, SbgInv.Figure
  end

  @required_fields ~w(role_id figure_id)
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
