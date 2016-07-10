defmodule SbgInv.Repo.Migrations.AddTitleToScenarioResources do
  use Ecto.Migration

  def change do
    alter table(:scenario_resources) do
      add :title, :string
    end
  end
end
