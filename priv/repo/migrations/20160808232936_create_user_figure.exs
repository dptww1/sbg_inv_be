defmodule SbgInv.Repo.Migrations.CreateUserFigure do
  use Ecto.Migration

  def change do
    create table(:user_figures) do
      add :user_id, :integer
      add :owned, :integer
      add :painted, :integer
      add :figure_id, references(:figures, on_delete: :nothing)

      timestamps()
    end

    create index(:user_figures, [:figure_id])
  end
end
