defmodule SbgInv.Repo.Migrations.AddAboutAndFaqs do
  use Ecto.Migration

  def change do
    create table(:about) do
      add :body_text, :text

      timestamps()
    end

    create table(:faqs) do
      add :question, :text
      add :answer, :text
      add :sort_order, :integer

      timestamps()
    end
  end
end
