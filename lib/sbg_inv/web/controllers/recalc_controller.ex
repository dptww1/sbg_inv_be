defmodule SbgInv.Web.RecalcController do

  use SbgInv.Web, :controller

  def index(conn, params) do
    IO.puts "----params"
    IO.inspect params
    IO.puts "----"

    user_id = Map.get(params, "uid", "1")
              |> String.to_integer

    Task.start_link(fn -> SbgInv.Web.RecalcUserScenarioTask.do_task(user_id) end)

    text conn, "Starting recalc task at " <>
               NaiveDateTime.to_string(NaiveDateTime.utc_now()) <>
               " for user " <>
               Integer.to_string(user_id)
  end
end
