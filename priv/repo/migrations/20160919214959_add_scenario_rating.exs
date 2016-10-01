defmodule SbgInv.Repo.Migrations.AddScenarioRating do
  use Ecto.Migration

  def change do
    alter table(:scenarios) do
      add :rating, :real
      add :num_votes, :integer
    end
  end
end
