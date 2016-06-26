defmodule SbgInv.ScenarioTest do
  use SbgInv.ModelCase

  alias SbgInv.Scenario

  @valid_attrs %{blurb: "some content", date_age: 42, date_year: 42, is_canonical: true, name: "some content", size: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Scenario.changeset(%Scenario{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Scenario.changeset(%Scenario{}, @invalid_attrs)
    refute changeset.valid?
  end
end
