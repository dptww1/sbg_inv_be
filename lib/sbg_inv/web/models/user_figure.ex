defmodule SbgInv.Web.UserFigure do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Figure, UserFigure}

  schema "user_figures" do
    field :user_id, :integer
    field :owned, :integer
    field :painted, :integer

    belongs_to :figure, Figure

    timestamps()
  end

  @required_fields [:user_id, :figure_id, :owned, :painted]

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

  def query_by_id_for_user(figure_id, user_id) do
    from uf in UserFigure,
    where: uf.figure_id == ^figure_id and uf.user_id == ^user_id
  end
end
