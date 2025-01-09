defmodule SbgInv.Web.NewsItemView do

  use SbgInv.Web, :view

  def render("index.json", %{news_items: news_items}) do
    %{data: render_many(news_items, __MODULE__, "news_item.json")}
  end

  def render("news_item.json", %{news_item: news_item}) do
    %{
      id: news_item.id,
      item_text: news_item.item_text,
      item_date: news_item.item_date
    }
  end
end
