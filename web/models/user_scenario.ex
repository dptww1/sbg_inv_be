defmodule SbgInv.UserScenario do
  use SbgInv.Web, :model

  schema "user_scenarios" do
    field :user_id, :integer
    field :rating, :integer
    field :owned, :integer
    field :painted, :integer

    belongs_to :scenario, SbgInv.Scenario

    timestamps
  end

  @required_fields ~w(user_id scenario_id)
  @optional_fields ~w(rating owned painted)

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
