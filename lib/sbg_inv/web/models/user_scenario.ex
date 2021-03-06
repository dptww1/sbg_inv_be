defmodule SbgInv.Web.UserScenario do

  use SbgInv.Web, :model

  alias SbgInv.Web.Scenario

  schema "user_scenarios" do
    field :user_id, :integer
    field :rating, :integer
    field :owned, :integer
    field :painted, :integer

    belongs_to :scenario, Scenario

    timestamps()
  end

  @required_fields [:user_id, :scenario_id]
  @optional_fields [:rating, :owned, :painted]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_number(:rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 5)
  end
end
