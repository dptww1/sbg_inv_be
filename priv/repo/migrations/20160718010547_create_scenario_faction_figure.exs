defmodule SbgInv.Repo.Migrations.CreateScenarioFactionFigure do
  use Ecto.Migration

  def change do
    create table(:scenario_faction_figures) do
      add :scenario_faction_id, references(:scenario_factions, on_delete: :nothing)
      add :amount, :integer
      add :sort_order, :integer
      add :figure_id, references(:figures, on_delete: :nothing)

      timestamps
    end
    create index(:scenario_faction_figures, [:scenario_faction_id])
    create index(:scenario_faction_figures, [:figure_id])

  end
end
