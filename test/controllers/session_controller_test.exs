# test/controllers/session_controller_test.exs
defmodule SbgInv.SessionControllerTest do
  use SbgInv.ConnCase

  alias SbgInv.Session
  alias SbgInv.User

  @valid_attrs %{name: "no one", email: "foo@bar.com", password: "s3cr3t"}

  setup %{conn: conn} do
    changeset =  User.registration_changeset(%User{}, @valid_attrs)
    Repo.insert changeset
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: @valid_attrs
    resp = json_response(conn, 201)
    assert resp["data"]["token"]
    assert resp["data"]["name"]
    assert Repo.get_by(Session, token: resp["data"]["token"])
  end

  test "does not create resource and renders errors when password is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :password, "notright")
    assert json_response(conn, 401)["errors"] != %{}
  end

  test "does not create resource and renders errors when email is invalid", %{conn: conn} do
    conn = post conn, session_path(conn, :create), user: Map.put(@valid_attrs, :email, "not@found.com")
    assert json_response(conn, 401)["errors"] != %{}
  end
end
