defmodule SbgInv.Repo.Migrations.CreateScenario do
  use Ecto.Migration

  def change do
    create table(:scenarios) do
      add :name, :string
      add :blurb, :text
      add :date_age, :integer
      add :date_year, :integer
      add :size, :integer
      add :map_width, :integer
      add :map_height, :integer
      add :location, :integer

      timestamps
    end

  end
end
