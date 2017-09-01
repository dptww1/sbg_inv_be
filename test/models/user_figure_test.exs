defmodule SbgInv.UserFigureTest do

  use SbgInv.ModelCase

  alias SbgInv.Web.UserFigure

  @valid_attrs %{owned: 42, painted: 42, user_id: 42, figure_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserFigure.changeset(%UserFigure{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserFigure.changeset(%UserFigure{}, @invalid_attrs)
    refute changeset.valid?
  end
end
