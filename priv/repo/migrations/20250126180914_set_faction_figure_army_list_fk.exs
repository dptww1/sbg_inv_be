defmodule SbgInv.Repo.Migrations.SetFactionFigureArmyListFk do
  use Ecto.Migration

  def up do
    execute "DELETE FROM faction_figures WHERE faction_id NOT in (SELECT id FROM army_lists)"

    alter table(:faction_figures) do
      modify :faction_id, references(:army_lists)
    end
  end

  def down do
    execute "ALTER TABLE faction_figures DROP CONSTRAINT faction_figures_faction_id_fkey"

    alter table(:faction_figures) do
      modify :faction_id, :integer
    end
  end
end
