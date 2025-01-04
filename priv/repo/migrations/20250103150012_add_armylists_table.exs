defmodule SbgInv.Repo.Migrations.AddArmyListsTable do
  use Ecto.Migration

  def change do
    create table(:army_lists) do
      add :name, :string
      add :abbrev, :string
      add :alignment, :integer
      add :legacy, :boolean

      timestamps()
    end

    create index(:army_lists, [:abbrev])

    create table(:army_lists_sources) do
      add :army_list_id, references(:army_lists, on_delete: :delete_all)
      add :book, :integer
      add :issue, :string
      add :page, :integer
      add :url, :string
      add :sort_order, :integer

      timestamps()
    end

    create index(:army_lists_sources, [:army_list_id])
  end
end
