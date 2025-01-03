defmodule SbgInv.Repo.Migrations.DeleteCharacterRuleFields do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      remove(:book)
      remove(:page)
    end
  end
end
