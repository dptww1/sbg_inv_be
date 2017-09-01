defmodule SbgInv.Web.UserFigureHistory do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Figure, User}

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

  @required_fields [:user_id, :amount, :figure_id, :op, :new_owned, :new_painted, :op_date]
  @optional_fields [:notes]

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
