defmodule SbgInv.Web.ScenarioResource do

  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.{Scenario, ScenarioResource}

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

  def query_by_id(id) do
    from sr in ScenarioResource,
    where: sr.id == ^id
  end

  def query_by_date_range(from_date, to_date, limit) do
    from sr in ScenarioResource,
    where: sr.updated_at >= ^from_date
       and sr.updated_at <= ^to_date
       and sr.resource_type != :source,
    order_by: [desc: sr.updated_at],
    limit: ^limit,
    preload: :scenario
  end
end
