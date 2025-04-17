defmodule SbgInv.Web.JavascriptView do
  use SbgInv.Web, :view

  alias SbgInv.Web.{ArmyList, Book}
  alias SbgInv.Repo

  def army_lists do
    ArmyList.query_all() |> Repo.all()
  end

  def books do
    Book.query_all() |> Repo.all()
  end
end
