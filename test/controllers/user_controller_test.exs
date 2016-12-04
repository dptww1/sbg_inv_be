defmodule SbgInv.UserControllerTest do
  use SbgInv.ConnCase

  alias SbgInv.{TestHelper, User}

  @valid_attrs %{name: "nobody", email: "foo@bar.com", password: "s3cr3t"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    body = json_response(conn, 201)
    assert body["data"]["id"]
    assert body["data"]["email"]
    refute body["data"]["password"]
    assert Repo.get_by(User, email: "foo@bar.com")
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates user's email and password with proper credentials", %{conn: conn} do
    user = TestHelper.create_user
    conn = TestHelper.create_session(conn, user)
    conn = put conn, user_path(conn, :update, user), user: %{email: "abc@example.com", password: "123456" }

    assert json_response(conn, 200)["data"]["id"] == user.id
    user_chk = Repo.get_by(User, %{email: "abc@example.com"})
    assert user_chk
    assert user_chk.password_hash != user.password_hash
  end

  test "updates email only when no password supplied", %{conn: conn} do
    user = TestHelper.create_user
    conn = TestHelper.create_session(conn, user)
    conn = put conn, user_path(conn, :update, user), user: %{email: "abc@example.com" }

    assert json_response(conn, 200)["data"]["id"] == user.id
    user_chk = Repo.get_by(User, %{email: "abc@example.com"})
    assert user_chk
    assert user_chk.password_hash == user.password_hash
  end

  test "updates password only when no email supplied", %{conn: conn} do
    user = TestHelper.create_user
    conn = TestHelper.create_session(conn, user)
    conn = put conn, user_path(conn, :update, user), user: %{password: "random string" }

    assert json_response(conn, 200)["data"]["id"] == user.id
    user_chk = Repo.get_by(User, %{id: user.id})
    assert user_chk
    assert user_chk.password_hash != user.password_hash
    assert user_chk.email == user.email
  end
end
