defmodule SbgInv.UserFigure do
  use SbgInv.Web, :model

  schema "user_figures" do
    field :user_id, :integer
    field :owned, :integer
    field :painted, :integer

    belongs_to :figure, SbgInv.Figure

    timestamps
  end

  @required_fields ~w(user_id owned painted)
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
