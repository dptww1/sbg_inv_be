defmodule SbgInv.Web.NewsItemController do

  use SbgInv.Web, :controller

  import SbgInv.Web.ControllerMacros

  alias SbgInv.Web.{NewsItem}

  action_fallback SbgInv.Web.FallbackController

  def index(conn, params) do
    limit = Map.get(params, "n", 3)
    from  = Map.get(params, "from", "2000-01-01")
    to    = Map.get(params, "to", "3000-01-01")

    news_items = Repo.all(NewsItem.query_by_date_range(from, to, limit))

    render(conn, "index.json", news_items: news_items)
  end

  def create(conn, %{"news_item" => params}) do
    with_admin_user conn do
      update_or_create(conn, %NewsItem{}, params)
    end
  end

  def update(conn, %{"id" => id, "news_item" => params}) do
    with_admin_user conn do
      item =
        NewsItem.query_by_id(id)
        |> Repo.one

      update_or_create(conn, item, params)
    end
  end

  def delete(conn, %{"id" => id}) do
    with_admin_user conn do
      item =
        NewsItem.query_by_id(id)
        |> Repo.one

      if item do
        Repo.delete!(item)
        send_resp conn, :no_content, ""
      else
        send_resp conn, :not_found, ""
      end
    end
  end

  defp update_or_create(conn, news_item, params) do
    changeset = NewsItem.changeset(news_item, params)

    case Repo.insert_or_update(changeset) do
    {:ok, news_item} ->
      render(conn, "news_item.json", news_item: news_item)

    {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end
end
