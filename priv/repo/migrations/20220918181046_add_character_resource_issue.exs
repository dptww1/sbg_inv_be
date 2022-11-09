defmodule SbgInv.Repo.Migrations.AddCharacterResourceIssue do
  use Ecto.Migration

  def change do
    alter table(:character_resources) do
      add :issue, :text
      timestamps
    end
  end
end
