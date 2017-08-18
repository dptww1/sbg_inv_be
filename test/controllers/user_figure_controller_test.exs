# test/controllers/user_figure_controller_test.exs
defmodule SbgInv.Web.UserFigureControllerTest do
  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.UserFigure

  test "invalid users cannot post", %{conn: conn} do
    conn = post conn, user_figure_path(conn, :create), %{"user_figure" => %{}}
    assert conn.status == 401
  end

  test "valid user can buy unpainted figures", %{conn: conn} do
    %{conn: conn, const_data: const_data, user: user} = TestHelper.set_up_std_scenario(conn)

    figure_id = TestHelper.std_scenario_figure_id(const_data, 0)

    conn = post conn, user_figure_path(conn, :create), %{"user_figure" => %{user_id: user.id, id: figure_id, owned: 12}}
    assert conn.status == 204

    check = Repo.get_by!(UserFigure, user_id: user.id, figure_id: figure_id)
    assert check.owned == 12
    assert check.painted == 2
  end
end
