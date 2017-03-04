defmodule SbgInv.ScenarioFactionTest do

  use SbgInv.ModelCase

  alias SbgInv.Web.ScenarioFaction

  @valid_attrs %{scenario_id: 1, actual_points: 42, faction: 1, sort_order: 42, suggested_points: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ScenarioFaction.changeset(%ScenarioFaction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ScenarioFaction.changeset(%ScenarioFaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
