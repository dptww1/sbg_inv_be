defmodule SbgInv.Repo.Migrations.AddFactionToCharacters do
  use Ecto.Migration

  def change do
    alter table(:characters) do
      add :faction, :int
    end
  end
end
