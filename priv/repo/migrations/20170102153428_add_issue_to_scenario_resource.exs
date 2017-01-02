defmodule SbgInv.Repo.Migrations.AddIssueToScenarioResource do
  use Ecto.Migration

  def change do
    alter table(:scenario_resources) do
      add :issue, :integer
    end
  end
end
