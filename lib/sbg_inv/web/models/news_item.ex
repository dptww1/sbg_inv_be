defmodule SbgInv.Web.NewsItem do

  use SbgInv.Web, :model

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
end
