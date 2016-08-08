defmodule SbgInv.Repo.Migrations.AddFigurePlurals do
  use Ecto.Migration

  def change do
    alter table(:figures) do
      add :plural_name, :string
    end
  end
end
