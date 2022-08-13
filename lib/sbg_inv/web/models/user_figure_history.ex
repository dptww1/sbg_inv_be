defmodule SbgInv.Web.UserFigureHistory do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Figure, User, UserFigureHistory}

  schema "user_figure_history" do
    field :op, UserFigureOp
    field :amount, :integer
    field :new_owned, :integer
    field :new_painted, :integer
    field :op_date, :date
    field :notes, :string

    belongs_to :user, User
    belongs_to :figure, Figure

    timestamps()
  end

  @required_fields [:user_id, :amount, :figure_id, :op, :op_date]
  @optional_fields [:notes, :new_owned, :new_painted]

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def query_by_id(id) do
    from ufh in UserFigureHistory,
    where: ufh.id == ^id
  end

  def query_by_date_range(from_date, to_date, user_id) do
    from ufh in UserFigureHistory,
    where: ufh.user_id == ^user_id
      and ufh.op_date >= ^from_date
      and ufh.op_date <= ^to_date,
    order_by: [asc: :op_date],
    preload: [:figure]
  end
end
