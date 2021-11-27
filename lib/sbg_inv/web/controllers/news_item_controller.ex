defmodule SbgInv.Web.NewsItemController do

  use SbgInv.Web, :controller

  import Ecto.Query

  alias SbgInv.Web.{Authentication, NewsItem}

  action_fallback SbgInv.Web.FallbackController

  def index(conn, params) do
    limit = Map.get(params, "n", 3)
    from  = Map.get(params, "from", "2000-01-01")
    to    = Map.get(params, "to", "3000-01-01")

    query = NewsItem
            |> limit(^limit)
            |> where([n], n.item_date >= ^from)
            |> where([n], n.item_date <= ^to)
            |> order_by([desc: :item_date])
    news_items = Repo.all(query)

    render(conn, "index.json", news_items: news_items)
  end

  def create(conn, %{"news_item" => params}) do
    conn = Authentication.admin_required(conn)

    if (conn.halted) do
      send_resp(conn, :unauthorized, "")

    else
      update_or_create(conn, %NewsItem{}, params)
    end
  end

  def update_or_create(conn, news_item, params) do
    changeset = NewsItem.changeset(news_item, params)

    case Repo.insert_or_update(changeset) do
    {:ok, _news_item} ->
        send_resp(conn, :accepted, "")

    {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end
end
