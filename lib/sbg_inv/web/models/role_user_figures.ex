defmodule SbgInv.Web.RoleUserFigures do
  @moduledoc """
  A non-persistent model holding a list of RoleUserFigure and rollup totals.
  """

  defstruct total_owned: 0, total_painted: 0, figures: []
end
