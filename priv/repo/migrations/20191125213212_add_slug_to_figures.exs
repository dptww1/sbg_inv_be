defmodule SbgInv.Repo.Migrations.AddSlugToFigures do
  use Ecto.Migration

  def change do
    alter table(:figures) do
      add :slug, :string
    end
  end
end
