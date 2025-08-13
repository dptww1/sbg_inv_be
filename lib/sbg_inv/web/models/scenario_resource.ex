defmodule SbgInv.Web.ScenarioResource do

  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.{Book, Scenario, ScenarioResource}

  schema "scenario_resources" do
    field :resource_type, ScenarioResourceType
    field :issue, :string
    field :page, :integer
    field :title, :string
    field :url, :string
    field :sort_order, :integer

    timestamps()

    belongs_to :scenario, Scenario
    belongs_to :book, Book, source: :book, on_replace: :nilify
  end

  # :scenario_id is required by ScenarioResourceController but can't
  # be provided by ScenarioController#create/update, so it has to
  # be optional.
  @required_fields [:resource_type, :sort_order]
  @optional_fields [:scenario_id, :issue, :page, :title, :url]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> put_assoc(:book, Map.get(params, "book"))
    |> validate_required(@required_fields)
  end

  def query_by_id(id) do
    from sr in ScenarioResource,
    where: sr.id == ^id,
    preload: :book

  end

  def query_by_date_range(from_date, to_date, limit) do
    from sr in ScenarioResource,
    where: sr.updated_at >= ^from_date
       and sr.updated_at <= ^to_date
       and sr.resource_type != :source,
    order_by: [desc: sr.updated_at],
    limit: ^limit,
    preload: [:scenario, :book]
  end
end
