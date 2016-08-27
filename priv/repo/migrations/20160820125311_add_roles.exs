defmodule SbgInv.Repo.Migrations.AddRoles do
  use Ecto.Migration

  def change do
    rename table(:scenario_faction_figures), to: table(:roles)

    alter table (:roles) do
      remove :figure_id
      add :name, :string
    end

    create table(:role_figures) do
      add :role_id, references(:roles, on_delete: :nothing)
      add :figure_id, references(:figures, on_delete: :nothing)
    end

    create index(:role_figures, [:role_id])
    create index(:role_figures, [:figure_id])
  end
end
