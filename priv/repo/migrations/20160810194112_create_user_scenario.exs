defmodule SbgInv.Repo.Migrations.CreateUserScenario do
  use Ecto.Migration

  def change do
    create table(:user_scenarios) do
      add :user_id, :integer
      add :rating, :integer
      add :owned, :integer
      add :painted, :integer
      add :scenario_id, references(:scenarios, on_delete: :nothing)

      timestamps()
    end
    create index(:user_scenarios, [:scenario_id])

  end
end
