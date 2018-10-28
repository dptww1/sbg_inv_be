defmodule SbgInv.UserScenarioTest do

  use SbgInv.ModelCase

  alias SbgInv.Web.UserScenario

  @valid_attrs %{owned: 42, painted: 42, rating: 4, user_id: 42, scenario_id: 43}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserScenario.changeset(%UserScenario{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserScenario.changeset(%UserScenario{}, @invalid_attrs)
    refute changeset.valid?
  end
end
