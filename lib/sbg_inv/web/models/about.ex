defmodule SbgInv.Web.About do
  use SbgInv.Web, :model

  import Ecto.Query

  alias SbgInv.Web.About

  schema "about" do
    field :body_text, :string

    timestamps()
  end

  @required_fields [:body_text]

  def changeset(model, params \\%{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  def query_singleton() do
    from a in About
  end
end
