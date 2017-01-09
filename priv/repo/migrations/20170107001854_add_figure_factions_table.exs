defmodule SbgInv.Repo.Migrations.AddFactionFiguresTable do
  use Ecto.Migration

  def change do
    create table(:faction_figures) do
      add :faction_id, :integer
      add :figure_id, references(:figures, on_delete: :nothing)
    end

    create index(:faction_figures, [:faction_id])
    create index(:faction_figures, [:figure_id])
  end
end
