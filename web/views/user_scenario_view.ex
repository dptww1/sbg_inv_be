defmodule SbgInv.UserScenarioView do
  use SbgInv.Web, :view

  def render("user_scenario.json", %{user_scenario: user_scenario}) do
    %{
      rating: user_scenario.rating,
      owned: user_scenario.owned,
      painted: user_scenario.painted
    }
  end
end
