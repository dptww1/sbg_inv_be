# test/controllers/reset_password_controller_test.exs
defmodule SbgInv.Web.ResetPasswordControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.User

  test "resets password for user", %{conn: conn} do
    user = TestHelper.create_user
    assert user.password_hash == nil   # Test users have no passwords, so no password hashes either
    conn = post conn, Routes.reset_password_path(conn, :create), user: %{email: user.email}
    assert !conn.halted
    assert conn.status == 204
    check_user = Repo.get!(User, user.id)
    refute check_user.password_hash == nil
  end

  test "fails for unknown user", %{conn: conn} do
    conn = post conn, Routes.reset_password_path(conn, :create), user: %{email: "no-such-email-address"}
    assert conn.status == 404
  end
end
