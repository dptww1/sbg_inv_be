defmodule SbgInv.Web.NewsItem do

  use SbgInv.Web, :model

  import Ecto.Query

  schema "news_item" do
    field :item_text, :string
    field :item_date, :date
  end

  @required_fields [:item_text, :item_date]

  def changeset(model, params \\%{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  def query_by_date_range(from_date, to_date, limit) do
    from n in SbgInv.Web.NewsItem,
    where: n.item_date >= ^from_date
       and n.item_date <= ^to_date,
    order_by: [desc: n.item_date],
    limit: ^limit
  end

  def query_by_id(id) do
    from n in SbgInv.Web.NewsItem,
    where: n.id == ^id
  end
end
