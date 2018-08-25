defmodule SbgInv.Repo.Migrations.AddNewsItemTable do
  use Ecto.Migration

  def change do
    create table(:news_item) do
      add :item_text, :text
      add :item_date, :date
    end

    create index(:news_item, [:item_date])
  end
end
