defmodule SbgInv.ScenarioTest do

  use SbgInv.ModelCase

  alias SbgInv.Web.Scenario

  @valid_attrs %{blurb: "some content", date_age: 42, date_year: 42, date_month: 3, date_day: 15, name: "some content", size: 42,
                 map_width: 8, map_height: 15, location: :the_shire}
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
