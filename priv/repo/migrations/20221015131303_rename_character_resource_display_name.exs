defmodule SbgInv.Repo.Migrations.RenameCharacterResourceDisplayName do
  use Ecto.Migration

  def up do
    alter table(:character_resources) do
      remove :display_name
      add :title, :text
    end

    alter table(:characters) do
      add :num_analyses, :integer
      add :num_painting_guides, :integer
    end
  end

  def down do
    alter table(:character_resources) do
      remove :title
      add :display_name, :text
    end

    alter table(:characters) do
      remove :num_analyses
      remove :num_painting_guides
    end
  end
end
