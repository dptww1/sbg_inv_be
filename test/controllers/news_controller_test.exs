defmodule SbgInv.Web.NewsControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{NewsItem, User}

  @valid_attrs %{item_text: "foo", item_date: ~D[2020-10-20]}

  setup _context do
    _declare_news_item("a <b>c%20</b> d",       ~D[2018-08-01])
    _declare_news_item("Least Recent in July",  ~D[2018-07-15])
    _declare_news_item("Most Recent in July",   ~D[2018-07-21])
    _declare_news_item("Least Recent in April", ~D[2017-04-02])
    _declare_news_item("Most Recent in April",  ~D[2017-04-20])

    :ok
  end

  test "index returns sorted list with default of three items", %{conn: conn} do
    conn = get conn, Routes.news_item_path(conn, :index)
    assert json_response(conn, 200)["data"] == [
             %{"item_text" => "a <b>c%20</b> d",      "item_date" => "2018-08-01"},
             %{"item_text" => "Most Recent in July",  "item_date" => "2018-07-21"},
             %{"item_text" => "Least Recent in July", "item_date" => "2018-07-15"}
           ]
  end

  test "index returns sorted list with default of user-supplied number of item", %{conn: conn} do
    conn = get conn, Routes.news_item_path(conn, :index, %{"n" => 2})
    assert json_response(conn, 200)["data"] == [
             %{"item_text" => "a <b>c%20</b> d",      "item_date" => "2018-08-01"},
             %{"item_text" => "Most Recent in July",  "item_date" => "2018-07-21"}
           ]
  end

  test "index returns sorted list respecting 'from' date", %{conn: conn} do
    conn = get conn, Routes.news_item_path(conn, :index, %{"from" => "2017-04-03", "n" => 10})
    assert json_response(conn, 200)["data"] == [
             %{"item_text" => "a <b>c%20</b> d",       "item_date" => "2018-08-01"},
             %{"item_text" => "Most Recent in July",   "item_date" => "2018-07-21"},
             %{"item_text" => "Least Recent in July",  "item_date" => "2018-07-15"},
             %{"item_text" => "Most Recent in April",  "item_date" => "2017-04-20"}
           ]
  end

  test "index returns sorted list respecting 'to' date", %{conn: conn} do
    conn = get conn, Routes.news_item_path(conn, :index, %{"to" => "2018-01-01", "n" => 10})
    assert json_response(conn, 200)["data"] == [
             %{"item_text" => "Most Recent in April",  "item_date" => "2017-04-20"},
             %{"item_text" => "Least Recent in April", "item_date" => "2017-04-02"}
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

  test "admin user can create a valid news item", %{conn: conn} do
    user = Repo.insert! %User{name: "abc", email: "def@example.com", is_admin: true}
    conn = TestHelper.create_session(conn, user)
    conn = post conn, Routes.news_item_path(conn, :create), news_item: @valid_attrs
    assert conn.status == 202
  end

  defp _declare_news_item(text, date) do
    Repo.insert! %NewsItem{
      item_text: text,
      item_date: date
    }
  end
end
