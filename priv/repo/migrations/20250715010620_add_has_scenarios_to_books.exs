defmodule SbgInv.Repo.Migrations.AddHasScenariosToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :has_scenarios, :boolean
    end
  end
end
