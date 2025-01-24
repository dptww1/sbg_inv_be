defmodule SbgInv.Web.JavascriptView do
  use SbgInv.Web, :view

  alias SbgInv.Web.ArmyList
  alias SbgInv.Repo

  def army_lists do
    ArmyList.query_all() |> Repo.all()
  end
end
