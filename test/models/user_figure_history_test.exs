defmodule SbgInv.UserFigureHistoryTest do

  use SbgInv.ModelCase

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Figure, UserFigureHistory}

  @valid_attrs %{op: 1, amount: 2, new_owned: 1, new_painted: 1, op_date: %{day: 10, month: 8, year: 2017}, notes: "abc"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    user = TestHelper.create_user()
    figure = Repo.insert! %Figure{name: "ABC", plural_name: "DEF"}
    changeset = UserFigureHistory.changeset(%UserFigureHistory{}, Map.merge(@valid_attrs, %{user_id: user.id, figure_id: figure.id}))
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserFigureHistory.changeset(%UserFigureHistory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
