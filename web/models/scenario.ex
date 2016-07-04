defmodule SbgInv.Scenario do
  use SbgInv.Web, :model

  schema "scenarios" do
    field :name, :string
    field :blurb, :string
    field :date_age, :integer
    field :date_year, :integer
    field :is_canonical, :boolean, default: false
    field :size, :integer

    timestamps

    has_many :scenario_resources, SbgInv.ScenarioResource
  end

  @required_fields ~w(name blurb date_age date_year is_canonical size)
  @optional_fields ~w(scenario_resources)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
