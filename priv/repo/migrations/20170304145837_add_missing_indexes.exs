defmodule SbgInv.Repo.Migrations.AddMissingIndexes do
  use Ecto.Migration

  def change do
    create index(:user_figures, [:user_id])
    create index(:user_scenarios, [:user_id])
  end
end
