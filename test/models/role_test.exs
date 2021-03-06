defmodule SbgInv.RoleTest do

  use SbgInv.ModelCase

  alias SbgInv.Web.{Role, RoleUserFigure, RoleUserFigures}

  @valid_attrs %{amount: 42, name: "role1", scenario_faction_id: 42, sort_order: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Role.changeset(%Role{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Role.changeset(%Role{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "role_user_figures" do
    role = %Role{amount: 10, name: "roleName", figures: [
                    %{id: 11, name: "foo", plural_name: "foos", user_figure: [
                         %{figure_id: 11, user_id: 1, owned: 8, painted: 4}
                       ] },
                    %{id: 2, name: "bah", plural_name: "bahs", user_figure: [
                         %{figure_id: 2, user_id: 1, owned: 4, painted: 3}
                       ] }
                  ]}

    assert Role.role_user_figures(role) ==
      %RoleUserFigures{
        total_owned: 10,
        total_painted: 7,
        figures: [
          %RoleUserFigure{
            figure: %{
              id: 11,
              name: "foo",
              plural_name: "foos",
              user_figure: [
                %{figure_id: 11, owned: 8, painted: 4, user_id: 1}
              ]},
            name: "foos",
            owned: 8,
            painted: 4
          },
          %RoleUserFigure{
            figure: %{
              id: 2,
              name: "bah",
              plural_name: "bahs",
              user_figure: [%{figure_id: 2, owned: 4, painted: 3, user_id: 1}]
            },
            name: "bahs",
            owned: 2,
            painted: 3
          }
        ]
      }
  end
end
