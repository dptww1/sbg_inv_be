defmodule SbgInv.Repo.Migrations.RemoveScenarioResourcesNotes do
  use Ecto.Migration

  def change do
    alter table(:scenario_resources) do
      remove :notes
    end
  end
end
