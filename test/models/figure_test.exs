defmodule SbgInv.FigureTest do

  use SbgInv.ModelCase
  use Pathex

  alias SbgInv.TestHelper
  alias SbgInv.Web.{Character, FactionFigure, Figure, Role, ScenarioFaction, Scenario, ScenarioResource}
  alias SbgInv.Web.{UserFigure, UserFigureHistory}

  @valid_attrs %{name: "some content", type: :hero}
  @invalid_attrs %{}

  setup do
    # Create Figures and Characters
    decoy_char = Repo.insert!(%Character{name: "stu", faction: :minas_tirith, book: :sots, page: 42})
    decoy_figure = Repo.insert!(Figure.changeset_with_characters(%Figure{}, Map.put(@valid_attrs, :character_ids, [decoy_char.id])))

    check_char = Repo.insert!(%Character{name: "xyz", faction: :rohan, book: :gaw, page: 123})
    check_figure = Repo.insert!(Figure.changeset_with_characters(%Figure{}, Map.put(@valid_attrs, :character_ids, [check_char.id])))

    user = TestHelper.create_user()
    user2 = TestHelper.create_user("b", "c@d.com")

    # Create FactionFigures
    Repo.insert!(%FactionFigure{figure_id: check_figure.id, faction_id: :shire})
    Repo.insert!(%FactionFigure{figure_id: check_figure.id, faction_id: :rohan})
    Repo.insert!(%FactionFigure{figure_id: decoy_figure.id, faction_id: :angmar})

    # Create UserFigures
    Repo.insert!(%UserFigure{user_id: user.id, figure_id: check_figure.id, owned: 2, painted: 7})
    Repo.insert!(%UserFigure{user_id: user.id, figure_id: decoy_figure.id, owned: 1, painted: 3})
    Repo.insert!(%UserFigure{user_id: user2.id, figure_id: check_figure.id, owned: 0, painted: 0})

    # Create UserFigureHistorys
    Repo.insert!(%UserFigureHistory{figure_id: check_figure.id, user_id: user.id, op: :buy_unpainted, amount: 9, op_date: ~D[2022-04-02]})
    Repo.insert!(%UserFigureHistory{figure_id: check_figure.id, user_id: user.id, op: :paint, amount: 3, op_date: ~D[2022-03-24]})
    Repo.insert!(%UserFigureHistory{figure_id: check_figure.id, user_id: user2.id, op: :buy_painted, amount: 5, op_date: ~D[2021-12-20]})

    # Create Scenario
    scenario = Repo.insert!(%Scenario{name: "a", blurb: "b", date_age: 1, date_year: 2, date_month: 3, date_day: 4,
      size: 5, map_width: 6, map_height: 7, location: :rohan})

    # Create ScenarioResource
    Repo.insert!(%ScenarioResource{scenario_id: scenario.id, resource_type: :source, sort_order: 1})

    # Create ScenarioFaction
    sf = Repo.insert!(%ScenarioFaction{scenario_id: scenario.id, faction: :rohan, suggested_points: 0, actual_points: 0, sort_order: 1})

    # Create Role
    Repo.insert!(%Role{scenario_faction_id: sf.id, amount: 3, sort_order: 1, name: "t", figures: [check_figure]})

    # Return main structs for testing
    %{
      char: check_char,
      figure: check_figure,
      user: user,
      scenario: scenario
    }
  end

  test "changeset with valid attributes" do
    changeset = Figure.changeset(%Figure{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Figure.changeset(%Figure{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "find_by_id() works with valid id", context do
    fig = Figure.query_by_id(context.figure.id)
          |> Repo.one!

    assert fig.name == @valid_attrs.name
  end

  test "with_characters() works with valid id", context do
    fig = Figure.query_by_id(context.figure.id)
          |> Figure.with_characters
          |> Repo.one!

    assert fig.name == @valid_attrs.name
    assert length(fig.characters) == 1
    assert Enum.at(fig.characters, 0).name == "xyz"
  end

  test "with_user() works with no user", context do
    fig = Figure.query_by_id(context.figure.id)
          |> Figure.with_user(-1)
          |> Repo.one!

    assert fig.name == @valid_attrs.name
    assert length(fig.user_figure) == 0
  end

  test "with_user() works with valid user", context do
    fig = Figure.query_by_id(context.figure.id)
          |> Figure.with_user(context.user.id)
          |> Repo.one!

    assert fig.name == @valid_attrs.name
    assert Enum.at(fig.user_figure, 0).owned == 2
    assert Enum.at(fig.user_figure, 0).painted == 7
  end

  test "with_factions() works with a valid id", context do
    fig = Figure.query_by_id(context.figure.id)
          |> Figure.with_factions
          |> Repo.one!

    assert fig.name == @valid_attrs.name
    assert length(fig.faction_figure) == 2
    assert Enum.at(fig.faction_figure, 0).faction_id == :rohan
    assert Enum.at(fig.faction_figure, 1).faction_id == :shire
  end

  test "with_user_history() works with a valid id", context do
    fig = Figure.query_by_id(context.figure.id)
          |> Figure.with_user_history(context.user.id)
          |> Repo.one!

    assert fig.name == @valid_attrs.name
    assert length(fig.user_figure_history) == 2
    assert Enum.at(fig.user_figure_history, 0).op_date == ~D[2022-03-24]
    assert Enum.at(fig.user_figure_history, 1).op_date == ~D[2022-04-02]
  end

  test "with_scenarios() works with a valid id", context do
    fig = Figure.query_by_id(context.figure.id)
          |> Figure.with_scenarios
          |> Repo.one!

    assert fig.name == @valid_attrs.name
    assert Pathex.get(fig, path(:role / 0 / :name)) == "t"
    assert Pathex.get(fig, path(:role / 0 / :scenario_faction / :faction)) == :rohan
    assert Pathex.get(fig, path(:role / 0 / :scenario_faction / :scenario / :name)) == "a"
  end
end
