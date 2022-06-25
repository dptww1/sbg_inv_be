defmodule SbgInv.Repo.Migrations.AddCharactersTable do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :text
      add :book, :integer
      add :page, :integer

      timestamps()
    end

    create table(:character_figures) do
      add :character_id, references(:characters, on_delete: :delete_all)
      add :figure_id, references(:figures, on_delete: :delete_all)
    end

    create index(:character_figures, [:character_id])
    create index(:character_figures, [:figure_id])

    create table(:character_resources) do
      add :character_id, references(:characters, on_delete: :delete_all)
      add :display_name, :text
      add :url, :text
      add :book, :integer
      add :page, :integer
      add :type, :integer
    end

    create index(:character_resources, [:character_id])
  end
end
