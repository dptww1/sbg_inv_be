defmodule SbgInv.Repo.Migrations.AddCharactersTable do
  use Ecto.Migration

  def change do
    create table(:characters) do
      add :name, :text
      add :book, :integer
      add :page, :integer

      timestamps()
    end

    create table(:characters_figures) do
      add :character_id, references(:characters, on_delete: :delete_all)
      add :figure_id, references(:figures, on_delete: :delete_all)
    end

    create index(:characters_figures, [:character_id])
    create index(:characters_figures, [:figure_id])

    create table(:characters_resources) do
      add :character_id, references(:characters, on_delete: :delete_all)
      add :display_name, :text
      add :url, :text
      add :book, :integer
      add :page, :integer
      add :type, :integer
    end

    create index(:characters_resources, [:character_id])
  end
end
