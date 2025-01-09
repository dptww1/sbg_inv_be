defmodule SbgInv.Web.NewsControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{NewsItem, User}

  @valid_attrs %{item_text: "foo", item_date: ~D[2020-10-20]}

  setup _context do
    id1 = _declare_news_item("a <b>c%20</b> d",       ~D[2018-08-01])
    id2 = _declare_news_item("Least Recent in July",  ~D[2018-07-15])
    id3 = _declare_news_item("Most Recent in July",   ~D[2018-07-21])
    id4 = _declare_news_item("Least Recent in April", ~D[2017-04-02])
    id5 = _declare_news_item("Most Recent in April",  ~D[2017-04-20])

    {:ok,
      %{
        ids: %{
          item1_id: id1,
          item2_id: id2,
          item3_id: id3,
          item4_id: id4,
          item5_id: id5
        }
      }
    }
  end

  test "index returns sorted list with default of three items", %{conn: conn} = context do
    conn = get conn, Routes.news_item_path(conn, :index)
    assert json_response(conn, 200)["data"] == [
             %{"item_text" => "a <b>c%20</b> d",      "item_date" => "2018-08-01", "id" => context.ids.item1_id},
             %{"item_text" => "Most Recent in July",  "item_date" => "2018-07-21", "id" => context.ids.item3_id},
             %{"item_text" => "Least Recent in July", "item_date" => "2018-07-15", "id" => context.ids.item2_id}
           ]
  end

  test "index returns sorted list with user-supplied number of item", %{conn: conn} = context do
    conn = get conn, Routes.news_item_path(conn, :index, %{"n" => 2})
    assert json_response(conn, 200)["data"] == [
             %{"item_text" => "a <b>c%20</b> d",      "item_date" => "2018-08-01", "id" => context.ids.item1_id},
             %{"item_text" => "Most Recent in July",  "item_date" => "2018-07-21", "id" => context.ids.item3_id}
           ]
  end

  test "index returns sorted list respecting 'from' date", %{conn: conn} = context do
    conn = get conn, Routes.news_item_path(conn, :index, %{"from" => "2017-04-03", "n" => 10})
    assert json_response(conn, 200)["data"] == [
             %{"item_text" => "a <b>c%20</b> d",       "item_date" => "2018-08-01", "id" => context.ids.item1_id},
             %{"item_text" => "Most Recent in July",   "item_date" => "2018-07-21", "id" => context.ids.item3_id},
             %{"item_text" => "Least Recent in July",  "item_date" => "2018-07-15", "id" => context.ids.item2_id},
             %{"item_text" => "Most Recent in April",  "item_date" => "2017-04-20", "id" => context.ids.item5_id}
           ]
  end

  test "index returns sorted list respecting 'to' date", %{conn: conn} = context do
    conn = get conn, Routes.news_item_path(conn, :index, %{"to" => "2018-01-01", "n" => 10})
    assert json_response(conn, 200)["data"] == [
             %{"item_text" => "Most Recent in April",  "item_date" => "2017-04-20", "id" => context.ids.item5_id},
             %{"item_text" => "Least Recent in April", "item_date" => "2017-04-02", "id" => context.ids.item4_id}
           ]
  end

  test "unauthenticated user cannot create a news item", %{conn: conn} do
    conn = post conn, Routes.news_item_path(conn, :create), news_item: @valid_attrs
    assert conn.status == 401
  end

  test "non-admin user cannot create a news item", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn)
    conn = post conn, Routes.news_item_path(conn, :create), news_item: @valid_attrs
    assert conn.status == 401
  end

  test "unauthenticated user cannot edit a news item", %{conn: conn} do
    item = Repo.insert! %NewsItem{}
    conn = put conn, Routes.news_item_path(conn, :update, item), news_item: @valid_attrs
    assert conn.status == 401
  end

  test "non-admin user cannot edit a news item", %{conn: conn} do
    item = Repo.insert! %NewsItem{}
    conn = TestHelper.create_logged_in_user(conn)
    conn = put conn, Routes.news_item_path(conn, :update, item), news_item: @valid_attrs
    assert conn.status == 401
  end

  test "admin user can create a valid news item", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, Routes.news_item_path(conn, :create), news_item: @valid_attrs
    new_item = Repo.one!(from n in NewsItem, where: n.item_text == "foo")
    assert json_response(conn, 200) == %{
             "id" => new_item.id,
             "item_text" => @valid_attrs.item_text,
             "item_date" => Date.to_string(@valid_attrs.item_date)
           }
  end

  test "admin user can edit a valid news item", %{conn: conn} do
    item_id = _declare_news_item("TEMP", ~D[2000-01-01])
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = put conn, Routes.news_item_path(conn, :update, item_id), news_item: @valid_attrs
    assert json_response(conn, 200) == %{
             "id" => item_id,
             "item_text" => @valid_attrs.item_text,
             "item_date" => Date.to_string(@valid_attrs.item_date)
           }
  end

  test "anonymous user cannot delete a valid news item", %{conn: conn} = context do
    conn = delete conn, Routes.news_item_path(conn, :delete, context.ids.item3_id)
    assert conn.status == 401
  end

  test "non-admin user cannot delete a valid news item", %{conn: conn} = context do
    conn = TestHelper.create_logged_in_user(conn)
    conn = delete conn, Routes.news_item_path(conn, :delete, context.ids.item3_id)
    assert conn.status == 401
  end

  test "admin user can delete a valid news item", %{conn: conn} = context do
    conn = TestHelper.create_logged_in_user(conn, "admin_guy", "a@b.com", true)
    conn = delete conn, Routes.news_item_path(conn, :delete, context.ids.item3_id)
    assert conn.status == 204
    assert Enum.count(Repo.all(NewsItem)) == 4
  end

  defp _declare_news_item(text, date) do
    item = Repo.insert! %NewsItem{
      item_text: text,
      item_date: date
    }

    item.id
  end
end
