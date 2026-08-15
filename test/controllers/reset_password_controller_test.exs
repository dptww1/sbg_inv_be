# test/controllers/reset_password_controller_test.exs
defmodule SbgInv.Web.ResetPasswordControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.User

  import Swoosh.TestAssertions

  test "user can get reset password link", %{conn: conn} do
    user = TestHelper.create_user("noman", "noman@example.com")
    assert user.reset_token == nil   # Test users have no passwords, so no password hashes either
    conn = post conn, Routes.reset_password_path(conn, :create), user: %{email: user.email}

    assert conn.status == 204

    check_user = Repo.get!(User, user.id)
    assert check_user.reset_token != nil

    assert_email_sent(fn email ->
      String.contains?(email.html_body, check_user.reset_token)
    end)
  end

  test "user with reset token can reset password", %{conn: conn} do
    user = TestHelper.create_user("anon", "a@example.com", false, "abcd1234")
    |> User.update_password_changeset(%{password: "abc123"})
    |> Repo.update!

    assert Pbkdf2.verify_pass("abc123", user.password_hash)

    url = Routes.reset_password_path(conn, :create)
    conn = post conn, url, user: %{email: user.email, token: user.reset_token, password: "def456"}

    assert conn.status == 204

    check_user = User.query_by_id(user.id) |> Repo.one
    assert Pbkdf2.verify_pass("def456", check_user.password_hash)
    assert check_user.reset_token == nil
  end

  test "user with wrong token cannot reset password", %{conn: conn} do
    user = TestHelper.create_user("u2", "u2@example.com", false, "the-token")
    |> User.update_password_changeset(%{password: "xyz"})
    |> Repo.update!

    assert Pbkdf2.verify_pass("xyz", user.password_hash)

    url = Routes.reset_password_path(conn, :create)
    conn = post conn, url, user: %{email: user.email, token: "wrong-token", password: "456"}

    assert conn.status == 401

    check_user = User.query_by_id(user.id) |> Repo.one
    assert Pbkdf2.verify_pass("xyz", check_user.password_hash)
    assert user.reset_token == "the-token"
  end

  test "fails for unknown user", %{conn: conn} do
    conn = post conn, Routes.reset_password_path(conn, :create, user: %{email: "no-such-email-address"})
    assert conn.status == 404
  end
end
