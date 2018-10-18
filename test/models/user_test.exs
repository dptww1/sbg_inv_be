defmodule SbgInv.UserTest do

  use SbgInv.ModelCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.User

  @valid_attrs %{name: "Anonymous", email: "foo@bar.com", password: "secret"}
  @invalid_attrs %{}

  test "new user with valid attributes validates" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.changes.password_hash
    assert changeset.valid?
  end

  test "new user with empty attributes is invalid" do
    changeset = User.registration_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "new user, email too short is invalid" do
    changeset = User.registration_changeset(%User{}, Map.put(@valid_attrs, :email, ""))
    refute changeset.valid?
  end

  test "new user, email bad format is invalid" do
    changeset = User.registration_changeset(%User{}, Map.put(@valid_attrs, :email, "foo.com"))
    refute changeset.valid?
  end

  test "new user, password too short is invalid" do
    changeset = User.registration_changeset(%User{}, Map.put(@valid_attrs, :password, "12"))
    refute changeset.valid?
  end

  test "existing user with changed valid email validates" do
    user = TestHelper.create_user
    changeset = User.update_email_changeset(user, %{email: "bar@foo.com"})
    assert changeset.valid?
  end

  test "existing user with changed bad email is invalid" do
    user = TestHelper.create_user
    changeset = User.update_email_changeset(user, %{email: "b"})
    refute changeset.valid?
  end

  test "existing user with changed valid password validates" do
    user = TestHelper.create_user
    changeset = User.update_password_changeset(user, %{password: "fine"})
    assert changeset.valid?
  end

  test "existing user with changed bad password is invalid" do
    user = TestHelper.create_user
    changeset = User.update_password_changeset(user, %{password: ""})
    refute changeset.valid?
  end
end
