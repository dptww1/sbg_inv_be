defmodule SbgInv.Repo.Migrations.CreateUserFigureHistory do
  use Ecto.Migration

  def change do
    create table(:user_figure_history) do
      add :user_id, references(:users, on_delete: :nothing)
      add :figure_id, references(:figures, on_delete: :nothing)
      add :op, :integer
      add :amount, :integer
      add :new_owned, :integer
      add :new_painted, :integer
      add :op_date, :date
      add :notes, :text

      timestamps()
    end

    create index(:user_figure_history, [:user_id])
    create index(:user_figure_history, [:figure_id])
  end
end
