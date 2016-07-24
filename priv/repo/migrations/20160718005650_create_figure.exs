defmodule SbgInv.Repo.Migrations.CreateFigure do
  use Ecto.Migration

  def change do
    create table(:figures) do
      add :name, :string

      timestamps
    end

  end
end
