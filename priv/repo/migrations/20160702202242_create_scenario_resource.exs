defmodule SbgInv.Repo.Migrations.CreateScenarioResource do
  use Ecto.Migration

  def change do
    create table(:scenario_resources) do
      add :scenario_id, references(:scenarios)
      add :resource_type, :integer
      add :book, :integer
      add :page, :integer
      add :url, :text
      add :notes, :text
      add :sort_order, :integer

      timestamps()
    end

    create index(:scenario_resources, [:scenario_id])
    create index(:scenario_resources, [:sort_order])
  end
end
