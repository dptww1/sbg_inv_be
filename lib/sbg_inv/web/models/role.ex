defmodule SbgInv.Web.Role do

  use SbgInv.Web, :model

  alias SbgInv.Web.{Figure, RoleUserFigure, RoleUserFigures, ScenarioFaction}

  schema "roles" do
    field :amount, :integer
    field :sort_order, :integer
    field :name, :string

    timestamps()

    belongs_to :scenario_faction, ScenarioFaction, on_replace: :update

    many_to_many :figures, Figure, join_through: "role_figures"
  end

  @required_fields [:amount, :sort_order, :scenario_faction_id, :name]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  @doc """
  Gets a filled-in RoleUserFigures for the given Role.  Caller is assumed to have restricted
  the UserFigure relation to the proper user_id.  The totals will be capped at
  the Role.amount, so the constituent RoleUserFigure numbers might be smaller than what is in
  the corresponding UserFigure data.  The sort order is per `RoleUserFigure.sorter/2`
  """
  def role_user_figures(role) do
    Enum.map(role.figures, fn(f) -> RoleUserFigure.create(f) end)
    |> Enum.reduce(%RoleUserFigures{}, fn(ruf, acc) ->
         painted_remainder = role.amount - acc.total_painted
         painted_amt = min(painted_remainder, ruf.painted)

         owned_remainder = role.amount - acc.total_owned
         owned_amt = min(owned_remainder, ruf.owned)

         name = if(owned_amt > 1, do: ruf.figure.plural_name, else: ruf.figure.name)

         %RoleUserFigures{
           total_painted: acc.total_painted + painted_amt,
           total_owned: acc.total_owned + owned_amt,
           figures: acc.figures ++ [%{ruf | owned: owned_amt, painted: painted_amt, name: name}]
         }
       end)
  end
end
