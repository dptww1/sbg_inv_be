defmodule SbgInv.Web.RecalcController do

  use SbgInv.Web, :controller

  def index(conn, _params) do
    Task.start_link(fn -> SbgInv.Web.RecalcUserScenarioTask.do_task(1) end)   # TODO get user id from conn

    text conn, "Starting recalc task at " <> NaiveDateTime.to_string(NaiveDateTime.utc_now())
  end
end
