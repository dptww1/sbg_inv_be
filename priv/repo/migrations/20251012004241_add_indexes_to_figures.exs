defmodule SbgInv.Repo.Migrations.AddIndexesToFigures do
  use Ecto.Migration

  def change do
    create index :figures, :type
    create index :figures, :unique
  end
end
