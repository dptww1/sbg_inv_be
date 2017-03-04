defmodule SbgInv.FigureTest do

  use SbgInv.ModelCase

  alias SbgInv.Web.Figure

  @valid_attrs %{name: "some content", type: :hero}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Figure.changeset(%Figure{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Figure.changeset(%Figure{}, @invalid_attrs)
    refute changeset.valid?
  end
end
