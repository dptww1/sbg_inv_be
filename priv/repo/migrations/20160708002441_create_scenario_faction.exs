defmodule SbgInv.Repo.Migrations.CreateScenarioFaction do
  use Ecto.Migration

  def change do
    create table(:scenario_factions) do
      add :faction, :integer
      add :suggested_points, :integer
      add :actual_points, :integer
      add :sort_order, :integer
      add :scenario_id, references(:scenarios)

      timestamps()
    end
    create index(:scenario_factions, [:scenario_id])

  end
end
