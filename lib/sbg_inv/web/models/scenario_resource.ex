defmodule SbgInv.Web.ScenarioResource do

  use SbgInv.Web, :model

  alias SbgInv.Web.Scenario

  schema "scenario_resources" do
    field :resource_type, ScenarioResourceType
    field :book, ScenarioResourceBook
    field :issue, :string
    field :page, :integer
    field :title, :string
    field :url, :string
    field :notes, :string
    field :sort_order, :integer

    timestamps()

    belongs_to :scenario, Scenario
  end

  @required_fields [:scenario_id, :resource_type, :sort_order]
  @optional_fields [:book, :issue, :page, :title, :url, :notes]

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
