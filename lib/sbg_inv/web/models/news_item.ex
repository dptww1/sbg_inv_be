defmodule SbgInv.Web.NewsItem do

  use SbgInv.Web, :model

  schema "news_item" do
    field :item_text, :string
    field :item_date, :date
  end


end
