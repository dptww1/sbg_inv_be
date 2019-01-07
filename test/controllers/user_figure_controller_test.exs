# test/controllers/user_figure_controller_test.exs
defmodule SbgInv.Web.UserFigureControllerTest do
  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{UserFigure, UserFigureHistory}

  test "invalid users cannot post", %{conn: conn} do
    conn = post conn, Routes.user_figure_path(conn, :create), %{"user_figure" => %{}}
    assert conn.status == 401
  end

  test "valid user can buy unpainted figures", %{conn: conn} do
    %{conn: conn, const_data: const_data, user: user} = TestHelper.set_up_std_scenario(conn)

    figure_id = TestHelper.std_scenario_figure_id(const_data, 0)

    conn = post conn,
                Routes.user_figure_path(conn, :create),
                %{"user_figure" =>
                    %{
                        user_id: user.id, id: figure_id, amount: 10,
                        op_date: ~D[2017-08-10], new_painted: 2, new_owned: 12
                    }
                }
    assert conn.status == 204

    check = Repo.get_by!(UserFigure, user_id: user.id, figure_id: figure_id)
    assert check.owned   == 12
    assert check.painted == 2

    history_check = Repo.get_by!(UserFigureHistory, user_id: user.id, figure_id: figure_id)
    assert history_check.op          == :buy_unpainted
    assert history_check.amount      == 10
    assert history_check.new_owned   == 12
    assert history_check.new_painted == 2
  end
end
