defmodule SbgInv.Repo.Migrations.AddBooksTable do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :key, :string
      add :short_name, :string
      add :year, :string
      add :name, :string

      timestamps()
    end

    create unique_index(:books, [:key])
  end
end
