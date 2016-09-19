defmodule SbgInv.RoleUserFigure do
  @moduledoc """
  A non-persistent model combining a Figure and the corresponding UserFigure for a given user.
  """

  alias SbgInv.Figure

  defstruct owned: 0, painted: 1, figure: %Figure{}, name: ""

  @doc """
  Creates a RoleUserFigure based on the given Figure and the sole UserFigure. If the user has no UserFigure
  record for the given Figure, the default field values are used.  The `name` field is not filled
  by this method; it's up to the caller to determine whether to use the Figure's `name` or `plural_name`.
  """
  def create(figure) do
    uf = if(length(figure.user_figure) == 0, do: %SbgInv.RoleUserFigure{}, else: hd(figure.user_figure))
    %SbgInv.RoleUserFigure{
      owned: uf.owned,
      painted: uf.painted,
      figure: figure
    }
  end

  @doc """
  Provides a canonical sort order for RoleUserFigure.  Most painted > most owned > alphabetical.
  """
  def sorter(f1, f2) do
    d = f1.painted - f2.painted
    d = if(d == 0, do: f1.owned - f2.owned, else: d)
    if d != 0 do
      d > 0
    else
      f1.figure.name < f2.figure.name
    end
  end
end
