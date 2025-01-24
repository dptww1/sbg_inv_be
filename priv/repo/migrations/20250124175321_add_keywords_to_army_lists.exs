defmodule SbgInv.Repo.Migrations.AddKeywordsToArmyLists do
  use Ecto.Migration

  def change do
    alter table(:army_lists) do
      add :keywords, :string
    end
  end
end
