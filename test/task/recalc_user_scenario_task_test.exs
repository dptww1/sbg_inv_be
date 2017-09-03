defmodule SbgInv.RecalcUserScenarioTaskTest do

  use SbgInv.Web.ConnCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{RecalcUserScenarioTask, User, UserScenario}

  test "UserScenario rollup can be created", %{conn: conn} do
    %{conn: _conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user1)

    user = Repo.get_by!(User, email: "abc@def.com")

    Repo.delete_all(UserScenario)

    RecalcUserScenarioTask.do_task(user.id)

    user_scenario = Repo.get_by!(UserScenario, %{scenario_id: Map.get(const_data, "id"), user_id: user.id})
    assert 7 == user_scenario.owned
    assert 3 == user_scenario.painted

  end

  test "Existing UserScenario rollup can be updated", %{conn: conn} do
    %{conn: _conn, const_data: const_data} = TestHelper.set_up_std_scenario(conn, :user1)

    user = Repo.get_by!(User, email: "abc@def.com")

    RecalcUserScenarioTask.do_task(user.id)

    user_scenario = Repo.get_by!(UserScenario, %{scenario_id: Map.get(const_data, "id"), user_id: user.id})
    assert 7 == user_scenario.owned
    assert 3 == user_scenario.painted
  end
end
