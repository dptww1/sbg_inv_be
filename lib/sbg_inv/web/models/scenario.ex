defmodule SbgInv.Web.Scenario do

  use SbgInv.Web, :model

  alias SbgInv.Web.{ScenarioFaction, ScenarioResource, UserScenario}

  schema "scenarios" do
    field :name,         :string
    field :blurb,        :string
    field :date_age,     :integer
    field :date_year,    :integer
    field :date_month,   :integer
    field :date_day,     :integer
    field :size,         :integer
    field :map_width,    :integer
    field :map_height,   :integer
    field :location,     Location
    field :rating,       :float
    field :num_votes,    :integer

    timestamps

    has_many :scenario_resources, ScenarioResource
    has_many :scenario_factions, ScenarioFaction
    has_many :user_scenarios, UserScenario
  end

  @required_fields ~w(name blurb date_age date_year date_month date_day size map_width map_height location)
  @optional_fields ~w(rating num_votes)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> base_changeset(params)
    |> cast_assoc(:scenario_resources, params)
    |> cast_assoc(:scenario_factions, params)
  end

  def base_changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end