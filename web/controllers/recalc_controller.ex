defmodule SbgInv.RecalcController do
  use SbgInv.Web, :controller

  def index(conn, _params) do
    Task.start_link(fn -> SbgInv.RecalcUserScenarioTask.do_task(1) end)   # TODO get user id from conn

    text conn, "Starting recalc task at " <>
      Calendar.NaiveDateTime.Format.asctime(Calendar.NaiveDateTime.from_erl!(:calendar.local_time()))
  end
end
