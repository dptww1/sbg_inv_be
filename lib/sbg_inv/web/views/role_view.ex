defmodule SbgInv.Web.RoleView do

  use SbgInv.Web, :view

  alias SbgInv.Web.Role

  def render("role.json", %{role: role}) do
    %{
      id: role.id,
      amount: role.amount,
      name: role.name,
      sort_order: role.sort_order,
      figures: Enum.map(role.figures, fn(fig) ->
        %{
          figure_id: fig.id,
          name: if(role.amount > 1 && fig.plural_name, do: fig.plural_name, else: fig.name)
        }
        end)
    }
  end

  def render("role_for_user.json", %{role: role}) do
    user_figures = Role.role_user_figures role

    Map.merge(
      render("role.json", %{role: role}),
      %{
        num_painted: user_figures.total_painted,
        num_owned: user_figures.total_owned,
        figures: Enum.map(user_figures.figures, fn(uf) ->
          user_figure = if(length(uf.figure.user_figure) > 0, do: hd(uf.figure.user_figure), else: %{owned: 0, painted: 0})
          %{
            figure_id: uf.figure.id,
            name: if(user_figure.owned > 1 && uf.figure.plural_name, do: uf.figure.plural_name, else: uf.figure.name),
            plural_name: uf.figure.plural_name, # Bit of a hack: only FE role editing needs this
            owned: user_figure.owned,
            painted: user_figure.painted
          }
         end)
      })
  end
end
