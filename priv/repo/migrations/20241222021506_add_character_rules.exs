defmodule SbgInv.Repo.Migrations.AddCharacterRules do
  use Ecto.Migration

  def change do
    create table(:character_rules) do
      add :character_id, references(:characters, on_delete: :delete_all)
      add :name_override, :string
      add :book, :integer
      add :issue, :string
      add :page, :integer
      add :url, :string
      add :sort_order, :integer
      add :obsolete, :boolean

      timestamps()
    end

    create index(:character_rules, [:character_id])
  end
end
