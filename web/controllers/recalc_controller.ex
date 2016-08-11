defmodule SbgInv.RecalcController do
  use SbgInv.Web, :controller

#  alias SbgInv.Recalc

  def index(conn, _params) do
    text conn, "Starting recalc task at " <>
      Calendar.NaiveDateTime.Format.asctime(Calendar.NaiveDateTime.from_erl!(:calendar.local_time()))
  end
end
