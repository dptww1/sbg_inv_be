defmodule SbgInv.ScenarioFactionFigureTest do
  use SbgInv.ModelCase

  alias SbgInv.ScenarioFactionFigure

  @valid_attrs %{amount: 42, figure_id: 17, scenario_faction_id: 42, sort_order: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ScenarioFactionFigure.changeset(%ScenarioFactionFigure{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ScenarioFactionFigure.changeset(%ScenarioFactionFigure{}, @invalid_attrs)
    refute changeset.valid?
  end
end
