defmodule SbgInv.Web.RoleView do

  use SbgInv.Web, :view

  alias SbgInv.Web.Role

  def render("role.json", %{role: role}) do
    user_figures = Role.role_user_figures role
    %{
      id: role.id,
      amount: role.amount,
      name: role.name,
      num_painted: user_figures.total_painted,
      num_owned: user_figures.total_owned,
      figures: Enum.reduce(user_figures.figures, [], fn(uf, list) ->
        list ++ [
          %{
            figure_id: uf.figure.id,
            name: if(hd(uf.figure.user_figure).owned > 1, do: uf.figure.plural_name, else: uf.figure.name),
            owned: hd(uf.figure.user_figure).owned,
            painted: hd(uf.figure.user_figure).painted
          }
        ]
      end)
    }
  end
end
