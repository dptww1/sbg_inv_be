defmodule SbgInv.ScenarioResourceTest do

  use SbgInv.ModelCase

  alias SbgInv.Web.ScenarioResource

  @valid_attrs %{name: "some content", notes: "some content", page: 42, resource_type: 3, scenario_id: 42, sort_order: 42, url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ScenarioResource.changeset(%ScenarioResource{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ScenarioResource.changeset(%ScenarioResource{}, @invalid_attrs)
    refute changeset.valid?
  end
end
