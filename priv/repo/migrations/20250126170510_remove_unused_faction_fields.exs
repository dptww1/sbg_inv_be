defmodule SbgInv.Repo.Migrations.RemoveUnusedFactionFields do
  use Ecto.Migration

  def up do
    alter table(:characters) do
      remove :faction
    end

    alter table(:scenario_factions) do
      remove :faction
    end
  end

  def down do
    alter table(:characters) do
      add :faction, :integer
    end

    alter table(:scenario_factions) do
      add :faction, :integer
    end
  end
end
