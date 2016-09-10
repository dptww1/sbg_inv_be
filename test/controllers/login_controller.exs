defmodule SbgInv.TodoControllerTest do
  use SbgInv.ConnCase

  alias SbgInv.Todo
  alias SbgInv.User
  alias SbgInv.Session

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

  def create_todo(%{description: _description, owner_id: _owner_id} = options) do
    Todo.changeset(%Todo{}, options) |> Repo.insert!
  end

  test "lists all entries on index", %{conn: conn, current_user: current_user} do
    create_todo(%{description: "our first todo", owner_id: current_user.id})

    another_user = create_user(%{name: "johndoe"})
    create_todo(%{description: "thier first todo", owner_id: another_user.id})

    conn = get conn, todo_path(conn, :index)

    assert Enum.count(json_response(conn, 200)["data"]) == 1
    assert %{"description" => "our first todo"} = hd(json_response(conn, 200)["data"])
  end

  test "creates and renders resource when data is valid", %{conn: conn, current_user: current_user} do
    conn = post conn, todo_path(conn, :create), todo: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    todo = Repo.get_by(Todo, @valid_attrs)
    assert todo
    assert todo.owner_id == current_user.id
  end

end
