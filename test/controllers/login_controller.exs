defmodule SbgInv.Web.LoginControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.Web.{Session, User}

  @valid_attrs %{complete: true, description: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    user = create_user(%{name: "jane"})
    session = create_session(user)

    conn = conn
    |> put_req_header("accept", "application/json")
    |> put_req_header("authorization", "Token token=\"#{session.token}\"")
    {:ok, conn: conn, current_user: user }
  end

  def create_user(%{name: name}) do
    User.changeset(%User{}, %{email: "#{name}@example.com"}) |> Repo.insert!
  end

  def create_session(user) do
    # in the last blog post I had a copy-paste error
    # so you may need to use Session.registration_changeset
    Session.create_changeset(%Session{user_id: user.id}, %{}) |> Repo.insert!
  end
end
