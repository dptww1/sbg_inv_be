defmodule SbgInv.Web.UserHistoryControllerTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{User, UserFigureHistory}

  defp addHistory(fig_id, user_id, op, amt, notes, op_date \\ ~D[2014-03-04]) do
    Repo.insert! %UserFigureHistory{
      user_id: user_id,
      figure_id: fig_id,
      op: op,
      amount: amt,
      op_date: op_date,
      notes: notes
    }
  end

  test "delete user history works if admin", %{conn: conn} do
    fig = TestHelper.add_figure("fig1", "fig1s")
    user = TestHelper.create_user("u1", "u1@example.com")
    hist = addHistory(fig.id, user.id, :buy_unpainted, 12, "Notes")

    admin = Repo.insert! %User{name: "a", email: "a@a", is_admin: true}

    conn = TestHelper.create_session(conn, admin)

    conn = delete conn, Routes.user_history_path(conn, :delete, hist.id)
    assert conn.status == 204

    assert Repo.all(UserFigureHistory) == []
  end

  test "delete user history works if record owner", %{conn: conn} do
    fig = TestHelper.add_figure("fig1", "fig1s")
    user = TestHelper.create_user("u1", "u1@example.com")
    hist = addHistory(fig.id, user.id, :buy_unpainted, 12, "Notes")

    conn = TestHelper.create_session(conn, user)

    conn = delete conn, Routes.user_history_path(conn, :delete, hist.id)
    assert conn.status == 204

    assert Repo.all(UserFigureHistory) == []
  end

  test "delete user history fails if not record owner and not admin", %{conn: conn} do
    fig = TestHelper.add_figure("fig1", "fig1s")
    user = TestHelper.create_user("u1", "u1@example.com")
    hist = addHistory(fig.id, user.id, :buy_unpainted, 12, "Notes")

    user2 = TestHelper.create_user

    conn = TestHelper.create_session(conn, user2)

    conn = delete conn, Routes.user_history_path(conn, :delete, hist.id)
    assert conn.status == 401
  end

  test "edit history fails if not record owner and not admin", %{conn: conn} do
    fig = TestHelper.add_figure("fig1", "fig1s")
    user = TestHelper.create_user("u1", "u1@example.com")
    hist = addHistory(fig.id, user.id, :buy_unpainted, 12, "Notes")

    user2 = TestHelper.create_user

    conn = TestHelper.create_session(conn, user2)

    conn = put conn, Routes.user_history_path(conn, :update, hist.id), history: %{}
    assert conn.status == 401
  end

  test "user can edit history if record owner", %{conn: conn} do
    fig = TestHelper.add_figure("fig1", "fig1s")
    user = TestHelper.create_user("u1", "u1@example.com")
    hist = addHistory(fig.id, user.id, :buy_unpainted, 12, "Notes")

    conn = TestHelper.create_session(conn, user)

    new_data = %{op: :sell_unpainted, op_date: ~D[2019-03-01], amount: 8, notes: "ABC"}

    conn = put conn, Routes.user_history_path(conn, :update, hist.id), history: new_data

    assert conn.status == 204
    assert Repo.all(UserFigureHistory) |> Enum.count == 1

    hist_check = Repo.get!(UserFigureHistory, hist.id)

    new_data
    |> Map.keys
    |> Enum.each(&(assert new_data[&1] == Map.get(hist_check, &1)))
  end

  test "user can edit history if admin", %{conn: conn} do
    fig = TestHelper.add_figure("fig1", "fig1s")
    user = TestHelper.create_user("u1", "u1@example.com")
    hist = addHistory(fig.id, user.id, :buy_unpainted, 12, "Notes")

    admin = Repo.insert! %User{name: "a", email: "a@a", is_admin: true}

    conn = TestHelper.create_session(conn, admin)

    new_data = %{op: :sell_unpainted, op_date: ~D[2019-03-01], amount: 8, notes: "ABC"}

    conn = put conn, Routes.user_history_path(conn, :update, hist.id), history: new_data

    assert conn.status == 204
    assert Repo.all(UserFigureHistory) |> Enum.count == 1

    hist_check = Repo.get!(UserFigureHistory, hist.id)

    new_data
    |> Map.keys
    |> Enum.each(&(assert new_data[&1] == Map.get(hist_check, &1)))
  end

  test "user can get history list", %{conn: conn} do
    fig1 = TestHelper.add_figure("fig1", "fig1s")
    fig2 = TestHelper.add_figure("fig2", "fig2s")

    user1 = TestHelper.create_user("u1", "u1@example.com")
    user2 = TestHelper.create_user("u2", "u2@example.com")

    hist1 = addHistory(fig1.id, user1.id, :buy_unpainted, 4, "notes", ~D[2005-10-20])
            addHistory(fig1.id, user2.id, :buy_unpainted, 6, "tones", ~D[2005-10-21])
    hist2 = addHistory(fig2.id, user1.id, :buy_unpainted, 6, "tones", ~D[2005-12-20])
    hist3 = addHistory(fig1.id, user1.id, :buy_unpainted, 5, "onets", ~D[2006-10-19])
            addHistory(fig2.id, user1.id, :buy_unpainted, 5, "onets", ~D[2010-12-20])

    conn = TestHelper.create_session(conn, user1)

    conn = get conn, Routes.user_history_path(conn, :index, %{"from" => "1999-01-01", "to" => "2007-12-31"})

    assert json_response(conn, 200)["data"] == [
             %{
               "figure_id" => fig1.id,
               "name" => "fig1",
               "plural_name" => "fig1s",
               "op" => "buy_unpainted",
               "op_date" => "2005-10-20",
               "amount" => 4,
               "notes" => "notes",
               "id" => hist1.id,
               "user_id" => user1.id

             },
             %{
               "figure_id" => fig2.id,
               "name" => "fig2",
               "plural_name" => "fig2s",
               "op" => "buy_unpainted",
               "op_date" => "2005-12-20",
               "amount" => 6,
               "notes" => "tones",
               "id" => hist2.id,
               "user_id" => user1.id
             },
             %{
               "figure_id" => fig1.id,
               "name" => "fig1",
               "plural_name" => "fig1s",
               "op" => "buy_unpainted",
               "op_date" => "2006-10-19",
               "amount" => 5,
               "notes" => "onets",
               "id" => hist3.id,
               "user_id" => user1.id
             }
    ]
  end
end
