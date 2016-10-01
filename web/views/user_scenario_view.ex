defmodule SbgInv.UserScenarioView do
  use SbgInv.Web, :view

  def render("user_scenario.json", %{user_scenario: user_scenario}) do
    scenario = user_scenario.scenario

    # TODO: substitute 0s at the query/results stage, not the view stage
    %{
      avg_rating: if(scenario.rating, do: scenario.rating, else: 0),
      num_votes: if(scenario.num_votes, do: scenario.num_votes, else: 0),
      rating: if(user_scenario && user_scenario.rating, do: user_scenario.rating, else: 0),
      owned: if(user_scenario && user_scenario.owned, do: user_scenario.owned, else: 0),
      painted: if(user_scenario.painted && user_scenario.painted, do: user_scenario.painted, else: 0)
    }
  end
end
