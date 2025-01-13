defmodule SbgInv.Web.AboutControllerTest do
  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.About

  @valid_attrs %{body_text: "new text"}

  setup _context do
    Repo.insert(%About{body_text: "<p>first</p><p>second</p>"})
    :ok
  end

  test "anonymous user can get About text", %{conn: conn} do
    conn = get conn, Routes.about_path(conn, :index)
    assert json_response(conn, 200)["data"] == %{
             "about" => "<p>first</p><p>second</p>"
           }
  end

  test "admin user can update About text", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn, "jon", "a@b.com", true)
    conn = put conn, Routes.about_path(conn, :update, -1), about: @valid_attrs
    assert conn.status == 204
    assert Repo.one!(About).body_text == @valid_attrs.body_text
  end

  test "logged-in user cannot update About text", %{conn: conn} do
    conn = TestHelper.create_logged_in_user(conn, "jon", "a@b.com")
    conn = put conn, Routes.about_path(conn, :update, -1), about: @valid_attrs
    assert conn.status == 401
  end

  test "anonymous user cannot update About text", %{conn: conn} do
    conn = put conn, Routes.about_path(conn, :update, -1), about: @valid_attrs
    assert conn.status == 401
  end
end
