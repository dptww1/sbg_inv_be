defmodule SbgInv.Repo.Migrations.CreateFigure do
  use Ecto.Migration

  def change do
    create table(:figures) do
      add :name, :string
      add :type, :integer
      add :unique, :boolean, default: false
      timestamps()
    end

  end
end
