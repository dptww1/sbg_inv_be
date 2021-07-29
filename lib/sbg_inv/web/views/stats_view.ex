defmodule SbgInv.Web.StatsView do

  use SbgInv.Web, :view

  def render("index.json", %{stats: stats_map}) do
    %{
      data: stats_map
    }
  end
end
