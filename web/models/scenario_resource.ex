defmodule SbgInv.ScenarioResource do
  use SbgInv.Web, :model

  schema "scenario_resources" do
    field :resource_type, ScenarioResourceType
    field :book, ScenarioResourceBook
    field :page, :integer
    field :title, :string
    field :url, :string
    field :notes, :string
    field :sort_order, :integer

    timestamps

    belongs_to :scenario, SbgInv.Scenario
  end

  @required_fields ~w(scenario_id resource_type sort_order)
  @optional_fields ~w(book page title url notes)

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
